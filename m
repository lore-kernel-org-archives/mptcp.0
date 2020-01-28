Content-Type: multipart/mixed; boundary="===============7309810311217106052=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v3 net-next 1/2] mptcp: protocol: fix panic on
 user pointer access
Date: Mon, 27 Jan 2020 17:22:39 -0800
Message-ID: <alpine.OSX.2.21.2001271702020.11293@obarba-mobl2.amr.corp.intel.com>
In-Reply-To: 1a83de21-7bd7-4a05-30fe-52091efdc4a4@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 3529

--===============7309810311217106052==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Mon, 27 Jan 2020, Matthieu Baerts wrote:

> Hi Florian,
>
> On 27/01/2020 00:41, Florian Westphal wrote:
>> Its not possible to call the kernel_(s|g)etsockopt functions here,
>> the address points to user memory:
>
> I am sorry for this maybe stupid question but why can we not use these =

> functions directly? Is it because of the "(g|s)et_fs()"?

Yes, the set_fs(KERNEL_DS) bypasses some checks for userspace memory =

ranges.

>
> [...]
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index 39fdca79ce90..f8232e9f08e7 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -778,17 +778,23 @@ static void mptcp_destroy(struct sock *sk)
>>   {
>>   }
>>   +static int subflow_setsockopt(struct socket *sock, int level, int =

>> optname,
>> +			       char __user *optval, unsigned int optlen)
>> +{
>> +	if (level =3D=3D SOL_SOCKET)
>
> Can we arrive in this case with MPTCP? I guess not form the userspace' =

> syscall but maybe from somewhere else in the kernel code?

Right now there isn't any code in mptcp_setsockopt() that checks which =

levels or options are allowed through to the subflows. We discussed =

whitelisting the socket options allowed to pass through to the subflows - =

but the patch to whitelist TCP_CONGESTION was mostly dropped and allowed =

everything instead of allowing nothing. I'm not sure that's what was =

intended, I will add it to this week's agenda.

For this patch, though, the SOL_SOCKET check is needed to match =

kernel_setsockopt behavior.

I think this patch looks good, and we can handle the whitelisting in a =

separate patch depending on what we figure out in the meeting.

--
Mat Martineau
Intel
--===============7309810311217106052==--
