Content-Type: multipart/mixed; boundary="===============2472419815715323258=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC PATCH] mptcp: new sysctl to control the activation
 per NS
Date: Thu, 18 Jul 2019 08:37:05 +0200
Message-ID: <dadf73ac-7e39-7581-365f-e70d2ff28d9f@tessares.net>
In-Reply-To: e67f35023485defaffc7066f66352f01c3bf507a.camel@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1522

--===============2472419815715323258==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter,

Thank you for your reply!

On 18/07/2019 00:42, Peter Krystad wrote:
> On Wed, 2019-07-17 at 23:08 +0200, Matthieu Baerts wrote:
>> Hi Peter,
>>
>> On 17/07/2019 01:12, Peter Krystad wrote:
>>> Thanks for this patch Matthieu, I have a few tardy comments.
>>
>> Thank you for your review!
>>
>>> As a general comment another approach would be to use this enabled flag=
 to
>>> control whether MP_CAPABLE options are sent when establishing/accepting=
 an
>>> MPTCP connection. You can see my "/* @@ if MTPCP enabled */" comments w=
here
>>> subflow->request_mptcp is being set in protocol.c. This would be the si=
miliar
>>> behaviour to the mptcp.org version, you just get a (inefficient) TCP so=
cket
>>> when requesting MPTCP. You get the benefit of not surprising applicatio=
ns
>>> coded to use MPTCP at the drawback of some security exposure, as the ne=
w MPTCP
>>> fallback layer would still be used. But this is a pretty thin layer.
>>
>> That's an interesting point of view, I didn't have the same one when
>> creating this patch. For me and compared to the mptcp.org
>> implementation, an application that explicitly asks for IPPROTO_MPTCP
>> wants to have MPTCP. It should be ready to face the possibility that
>> MPTCP is not available or not supported by the kernel. Note that we
>> should certainly add a way for an app to know if a fallback to TCP has
>> been done but that's another topic.
>>
>> My point is that if MPTCP is disabled, it seems interesting to me to
>> directly tell that to the app and then not transparency fallback to TCP.
>>
>> But if we think that it might be interesting to transparently fallback
>> to TCP, we can do that. We can also use several values (1, 2, ...)
>> linked to different behaviours.
> =

> The code we have so far transparently falls back to TCP if the other end
> does not support/rejects MPTCP connection, so we should definitely discuss
> which approach we want to support. We will be removing code if we go as
> you suggest.

I think it is still important to transparently fall back to TCP if the
other end or any other device on the network does not support or does
not allow MPTCP. Because we don't necessarily want to stop and
re-establish a new TCP connection once a fall back to TCP is done.

But here, nothing has been sent to the wire, we can tell the app before
that MPTCP will not be used. And we can even tell it that it is due to a
"configuration issue".

If we do a transparent fall back to TCP, that could be nice to notify
the app. POLLPRI? sockopt?

>>
>>> See my comments to this specific patch below.
>>>
>>> On Thu, 2019-07-11 at 21:00 +0200, Matthieu Baerts wrote:
>>>> New MPTCP sockets will return -ENOPROTOOPT if MPTCP support is disabled
>>>> for the current net namespace.
>>>>
>>>> For security reasons, it is interesting to have a global switch for
>>>> MPTCP. To start, MPTCP will be disabled by default and only privileged
>>>> users will be able to modify this. The reason is that because MPTCP is
>>>> new, it will not be tested and reviewed by many and security issues can
>>>> then take time to be discovered and fixed.
>>>>
>>>> The value of this new sysctl can be different per namespace. We can th=
en
>>>> restrict the usage of MPTCP to the selected NS. In case of serious
>>>> issues with MPTCP, administrators can now easily turn MPTCP off.
>>>>
>>>> MPTCP' kselftest has been modified to validate that the correct error =
is
>>>> reported when creating a socket while MPTCP support is disabled.
>>>>
>>>> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
>>>> ---
>>>>
>>>> Notes:
>>>>     As just discussed at the meeting we just had, here is a RFC patch =
to
>>>>     add a new sysctl for MPTCP.
>>>>     =

>>>>     Because it is not linked to the protocol itself, I simply created =
a new
>>>>     file, ctrl.c like in mptcp.org.
>>>>     =

>>>>     A few questions:
>>>>     - Is it OK to reserve space per ns via the "pernet_operations"
>>>>       structure? Because MPTCP would not be compiled as a module, we c=
ould
>>>>       directly store stuff in the net structure as other parts of the =
code
>>>>       do but maybe better to keep MPTCP code on the side as done here.
>>>>     - In mptcp.org, all sysctls are prepended with 'mptcp_', e.g.
>>>>       'net.mptcp.mptcp_enabled'. Do we need this? Is it better to keep=
 the
>>>>       same names if possible or better to differentiate? In this versi=
on,
>>>>       'mptcp_' is not prepended.
>>>
>>> Differentiate, as you have done.
>>
>> Good thank you!
>>
>>>>     - This sysctl will only block new sockets to be created. Is it eno=
ugh?
>>>>     - ENOPROTOOPT is returned, maybe something else to return? EPERM is
>>>>       maybe too generic? ENOTSUPP is not translated by perror().
>>>>     - Should we start the documentation now for the sysctl?
>>>>     - A simple test has been added, because it is not linked to the re=
st, I
>>>>       put separeted as first test.
>>>>     - Of course do not hesitate to comment. Even on the idea of having=
 a
>>>>       sysctl for this purpose.
>>>>
>>>>  net/mptcp/Makefile                            |   2 +-
>>>>  net/mptcp/ctrl.c                              | 109 ++++++++++++++++++
>>>>  net/mptcp/protocol.c                          |  12 +-
>>>>  net/mptcp/protocol.h                          |   4 +
>>>>  .../selftests/net/mptcp/mptcp_connect.sh      |  24 ++++
>>>>  5 files changed, 148 insertions(+), 3 deletions(-)
>>>>  create mode 100644 net/mptcp/ctrl.c
>>>>
>>>> diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
>>>> index 7fe7aa64eda0..289fdf4339c1 100644
>>>> --- a/net/mptcp/Makefile
>>>> +++ b/net/mptcp/Makefile
>>>> @@ -1,4 +1,4 @@
>>>>  # SPDX-License-Identifier: GPL-2.0
>>>>  obj-$(CONFIG_MPTCP) +=3D mptcp.o
>>>>  =

>>>> -mptcp-y :=3D protocol.o subflow.o options.o token.o crypto.o pm.o
>>>> +mptcp-y :=3D protocol.o subflow.o options.o token.o crypto.o pm.o ctr=
l.o
>>>> diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
>>>
>>> The prefix 'ctl' is used in this file a bunch, so maybe ctl.c is a bett=
er
>>> name, or even 'sysctl.c'. That it is named this is mptcp.org version is=
n't
>>> much of a reason IMHO. :)
>>
>> My goal was to use this new file for everything not directly linked to
>> the protocol but to change different behaviours: sysctl, sockopts,
>> selection of the PMs or the packet schedulers, etc.
>>
>> What do you think? But we can also create different files if you think
>> that would be better.
>>
>>>> new file mode 100644
>>>> index 000000000000..4c9a6a2cfeb3
>>>> --- /dev/null
>>>> +++ b/net/mptcp/ctrl.c
>>
>> (...)
>>
>>>> +
>>>> +static struct pernet_operations mptcp_pernet_ops =3D {
>>>> +	.init =3D mptcp_net_init,
>>>> +	.exit =3D mptcp_net_exit,
>>>> +	.id =3D &mptcp_pernet_id,
>>>> +	.size =3D sizeof(struct mptcp_pernet),
>>>> +};
>>>> +
>>>> +void __init mptcp_init(void)
>>>
>>> I would prefer that the mptcp_init() in protocol.c remain the top-level=
 init
>>> routine and that it call a sub-level routine in this file the same as o=
ther
>>> files in "module". When TCP is calling mptcp_init() it is registering
>>> protocols, so the protocol routine should be at the top I think.
>>
>> Sure I can do that.
>>
>> I created this new file to be the central point to control the different
>> parts in MPTCP (sysctl, sockopt, PM selection, etc.) including the
>> protocol. But if we think it is better to init the protocol part, I am
>> fine with that.
> =

> I'm not too strong on this either way, what do others think?
> =

>>
>>>> +{
>>>> +	mptcp_proto_init();
>>>> +
>>>> +	if (register_pernet_subsys(&mptcp_pernet_ops) < 0)
>>>> +		panic("Failed to register MPTCP pernet subsystem.\n");
>>>> +}
>>>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>>>> index 774ed25d3b6d..18399cb63f35 100644
>>>> --- a/net/mptcp/protocol.c
>>>> +++ b/net/mptcp/protocol.c
>>>> @@ -559,6 +559,14 @@ static int mptcp_init_sock(struct sock *sk)
>>>>  	return 0;
>>>>  }
>>>>  =

>>>> +static int mptcp_init_sock_cb(struct sock *sk)
>>>> +{
>>>> +	if (!mptcp_is_enabled(sock_net(sk)))
>>>> +		return -ENOPROTOOPT;
>>>
>>> Can we just add this check to mptcp_init_sock() and not add the extra r=
outine?
>>
>> I created a new routine because mptcp_init_sock() is also called from
>> mptcp_accept(). The (initial) goal of this sysctl is not to allow
>> creation of new socket and not alter existing ones. We can also change
>> the definition if needed.
> =

> OK. I would still prefer the name of the callback in 'struct proto' to be
> mptcp_init_sock, and call a "__mptcp_init_sock" from mptcp_accept.

Sure I can do that!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============2472419815715323258==--
