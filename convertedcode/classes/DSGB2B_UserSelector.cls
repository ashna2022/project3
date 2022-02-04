/**
 * @description       : 
 * @author            : Rakesh Ramaswamy
 * @group             : 
 * @last modified on  : 02-03-2022
 * @last modified by  : Rakesh Ramaswamy
**/
public class DSGB2B_UserSelector {

    private static List<String> contAdditionalFields = new List<String>{
        'Account.IsBuyer'
    };

    private static final String RESELLER_TYPE = 'Channel';

    private static Map<Id, User> cachedUserById = new Map<Id, User>();
    private static Map<Id, Contact> contactsByIds = new Map<Id, Contact>();
 
    public Map<Id, Contact> getContactsByIds(Set<Id> contactIds) {
        return null;
    }

    public User getPortalUserInfo(Id userId) {
        if (userId == null) return null;

        if (cachedUserById.containsKey(userId)) {
            return cachedUserById.get(userId);
        }

        this.getPortalUsersInfo(new Set<Id>{
            userId
        });

        return cachedUserById.get(userId);
    }

    public List<User> getPortalUsersInfo(Set<Id> userIds) {
        if (userIds == null || userIds.isEmpty()) {
            return new List<User>();
        }

        Set<Id> clonedUserIds = userIds.clone();

        List<User> resultUsers = this.getCachedUsers(clonedUserIds);

        List<User> users = [
            SELECT
                Id,
                Name,
                Username,
                ContactId,
                Contact.Id,
                Contact.Name,
                Contact.Email,
                Contact.Phone,
                
                AccountId,
                Contact.Account.Id,
                Contact.Account.Name,
               
                
                Contact.Account.Type,
                FirstName,
                LastName,
                Phone,
                Email,
                UserType
            FROM User
            WHERE Id IN :clonedUserIds
        ];

        this.cacheUsers(clonedUserIds, users);

        resultUsers.addAll(this.getCachedUsers(clonedUserIds));

        return resultUsers;
    }

    private List<User> getCachedUsers(Set<Id> userIds) {
        List<User> cachedUsers = new List<User>();
        for (Id userId : userIds) {
            if (cachedUserById.containsKey(userId)) {
                cachedUsers.add(cachedUserById.get(userId));
                userIds.remove(userId);
            }
        }
        return cachedUsers;
    }

    private void cacheUsers(Set<Id> userIds, List<User> users) {
        Map<Id, User> userById = new Map<Id, User>(users);
        for (Id userId : userIds) {
            cachedUserById.put(userId, userById.get(userId));
        }
    }

}