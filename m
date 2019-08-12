Content-Type: multipart/mixed; boundary="===============5988937549121179556=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH v3 00/10] Implement outgoing MP_JOIN
Date: Mon, 12 Aug 2019 21:37:48 +0200
Message-ID: <e9766c3a-71d1-fe65-a68c-f5b6250508b6@tessares.net>
In-Reply-To: 3ea8f7461dc53afc87bd16a5063d66bdd69d21b8.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1627

--===============5988937549121179556==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter, Paolo, Mat,

On 08/08/2019 16:51, Paolo Abeni wrote:
> Hi all,
> On Wed, 2019-08-07 at 15:44 -0700, Peter Krystad wrote:
>> This is several accumulated fixes that are required for MP_JOIN
>> (secondary subflows) plus the outgoing code.
>>
>> Both outgoing and incoming MP_JOIN now inter-operate
>> with the multipath.org implementation although there is
>> still a deadlock when incoming is fully established.
>> Since the incoming direction did not work at all before
>> this is an improvement. I have not yet tested running our
>> implmentation against itself.
>>
>> The final patch in the set is an "interim path manager", this
>> is throw-away code that I include for testing purposes. For an
>> incoming connection it is necessary for the server to advertise
>> a secondary address and for my testing I have been hard-coding the IP
>> address of my secondary interface when I build the kernel.
>> Obviously not the final solution but we need to discuss what
>> approach to use for the self tests. I also think we may not want
>> to publish this patch on our net-next branch.
>>
>> v2:
>>   - move mptcp_options_received formatting to options.c
>>   - resolve conflicts with Davide's crypto commit
>>   - make helper for setting request fields
>>   - fix locking in token_lookup()
>>   - move token_lookup() to "Implement path manager interface commands:
>>     (where it belongs)
>>   - split interim path manager out of final commit, will submit seperate=
ly
>>   - remove use of local_id in pm_create_subflow
>>   - restrict announcing addresses to server side only
>>   - add one more commit with get_local_id fix for incoming MP_JOIN
>>
>> v3:
>>   - Revise nested if logic in options.c
>>   - set subflow->request_cksum correctly (do not support)
>>   - lock mptcp_sock in subflow_connect() and take ref
>>   - return EINPROGRESS from subflow_connect() in normal case
>>   - cleanup socket when bind()/connect() fails in subflow_connect()
>>   - take reference to mptcp_sock in token_join_request() and
>>     token_join_valid()
>>   - rename token_lookup() to token_lookup_get()
>>   - track remote token seperately in subflow (previously
>>     local token field was being overwritten, preventing cleanup)
>>   - take long-lived reference to mptcp_sock in token_new_subflow
> =

> I went through the whole series and it looks like all my comments has
> been addressed, thank you Peter!

Thank you for the patches and the reviews!

I just applied these 10 patches. Please check that everything looks good
to you, especially the patches that I had to split in multiple ones and
squash in different commits. Do not hesitate to tell me if the squashes
were not in the right commits or if I have to change stuffs.

Note that I just saw Mat's email on the patch number 8. Feel free to
continue the discussions there and create a new patch if needed.

The compilation is still OK. Tests are in progress. I will tell you
tomorrow if there is an issue with them.

I think I applied all accepted patches on the list. Do not hesitate to
tell me if other are also good to be applied ;)

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============5988937549121179556==--
