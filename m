Content-Type: multipart/mixed; boundary="===============0738968052381596361=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: Allow ip mptcp endpoint show
Date: Mon, 03 Aug 2020 20:19:15 +0200
Message-ID: <bf5aaf2f-e9f9-167f-3be9-e9e743f8fd1c@tessares.net>
In-Reply-To: 20200803173812.GG1761@MacBook-Pro-64.local
X-Status: 
X-Keywords:                  
X-UID: 5451

--===============0738968052381596361==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

On 03/08/2020 19:38, Christoph Paasch wrote:
> On 08/03/20 - 19:23, Davide Caratti wrote:
>> On Mon, 2020-08-03 at 10:10 -0700, Christoph Paasch wrote:
>>> The intention was to dump the entire address-list when no ID is given.
>>> However, the condition needs to rather check on argc as argv will always
>>> be !=3D NULL.
>>>
>>> Fixes: 7e0767cd862b ("add support for mptcp netlink interface")
>>> Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
>>> ---
>>>   ip/ipmptcp.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
>>> index bc12418bd39c..df38754c82b6 100644
>>> --- a/ip/ipmptcp.c
>>> +++ b/ip/ipmptcp.c
>>> @@ -273,7 +273,7 @@ static int mptcp_addr_show(int argc, char **argv)
>>>   	struct nlmsghdr *answer;
>>>   	int ret;
>>>   =

>>> -	if (!argv)
>>> +	if (argc =3D=3D 0)
>>>   		return mptcp_addr_dump();
>>>   =

>>>   	ret =3D mptcp_parse_opt(argc, argv, &req.n, false);
>>
>> I think I saw already this patch :-)
> =

> Interesting, I was on origin/master and not origin/main ... well, well...=
 :-)

Yeah, I didn't see that directly as well!
I am not sure it is a good idea to switch to a new default branch while =

still leaving "master" alive without any dedicated commit :)

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============0738968052381596361==--
