Content-Type: multipart/mixed; boundary="===============5532458745028604029=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 9/9] don't flag parent socket as RCV_SHUTDOWN
 if one one subflow has closed
Date: Tue, 03 Dec 2019 10:13:03 +0100
Message-ID: <7ffecd01-f428-b74b-4cc9-4ae9c642a788@tessares.net>
In-Reply-To: 096263668b065156c0b198a8e05790ab6b00530e.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2762

--===============5532458745028604029==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 03/12/2019 10:05, Paolo Abeni wrote:
> On Tue, 2019-12-03 at 08:44 +0100, Matthieu Baerts wrote:
>> Hi Florian, Paolo, Mat,
>>
>> On 02/12/2019 22:21, Paolo Abeni wrote:
>>> On Mon, 2019-12-02 at 20:10 +0100, Florian Westphal wrote:
>>
>> [...]
>>
>>> Thanks for addressing my comments.
>>>
>>> With 9/9 v2 the series is IMHO ready to me merged.
>>
>> Thank you for the nice patch series and the reviews!
>> Related to what we discussed yesterday, is it OK if I merge this after:
>>
>>    1) DATA_FIN
>>    2) MPTCPv1 =E2=86=92 wait a bit for a review
>>    3) SendMsg "refactor" =E2=86=92 if reviewed
>>
>> Or can I do that after the patches for MPTCPv1 if the patches to fix
>> sendmsg() have not been reviewed yet?
> =

> I think/hope this and sendmsg patches should not conflict much - but
> sendmsg patches do create quite of conflict with the following patches.
> =

> I think that appling this series after v1 could be a good option, will
> give extra time to review the sendmsg() patches, and I can rebase my
> tree to help the merging.

Thank you for your reply!

Sounds good to me. If there is nothing to change in sendmsg() patches =

after the review, I can also start applying them. If I am blocked, I can =

ask for help.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============5532458745028604029==--
