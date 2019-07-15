Content-Type: multipart/mixed; boundary="===============5817521692815765825=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC PATCH] mptcp: new sysctl to control the activation
 per NS
Date: Mon, 15 Jul 2019 20:44:40 +0200
Message-ID: <178bac59-10f1-8e1a-63a3-97286aca37ae@tessares.net>
In-Reply-To: CAPyD+=AL30XmZKiCLFhCV6wm9HDv0pmz_HE7paLcLpAkeXd2CA@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 1493

--===============5817521692815765825==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ossama,

Thank you for your review!

On 15/07/2019 20:17, Othman, Ossama wrote:
> Hi Matthieu,
> =

> On Thu, Jul 11, 2019 at 12:01 PM Matthieu Baerts
> <matthieu.baerts(a)tessares.net> wrote:
>> For security reasons, it is interesting to have a global switch for
>> MPTCP. To start, MPTCP will be disabled by default and only privileged
>> users will be able to modify this. The reason is that because MPTCP is
>> new, it will not be tested and reviewed by many and security issues can
>> then take time to be discovered and fixed.
> =

> Do we need to be concerned about this new sysctl variable being used
> to maliciously enable or disable MPTCP?

I am sorry, I don't understand your question?

The goal would be to add a new sysctl variable as a global "safeguard".
The application will continue to explicitly ask for MPTCP using
IPPROTO_MPTCP.

> =

>>     - In mptcp.org, all sysctls are prepended with 'mptcp_', e.g.
>>       'net.mptcp.mptcp_enabled'. Do we need this? Is it better to keep t=
he
>>       same names if possible or better to differentiate? In this version,
>>       'mptcp_' is not prepended.
> =

> The "mptcpd_" prefix seems redundant since the variable is already
> part of the "net.mptcp" namespace.  If we're going to differentiate
> sysctl interfaces between the two kernels, now is a good time to do so
> given where we are in the upstream kernel development.

I agree with you, thank you for your feedback.

>>     - ENOPROTOOPT is returned, maybe something else to return? EPERM is
>>       maybe too generic? ENOTSUPP is not translated by perror().
> =

> ENOPROTOOPT appears to be more relevant to socket options, e.g. the
> setsockopt(2) man page states the following:
> =

>        ENOPROTOOPT
>                 The option is unknown at the level indicated.
> =

> According to the socket(2) man page, EINVAL might be the better errno:
> =

>        EINVAL Unknown protocol, or protocol family not available.

I didn't read the socket manpage, I should have done that :)

I would prefer not to return EINVAL as it is already returned if the
protocol is unknown, e.g. if the kernel does not support MPTCP.
From an application point of view, I think it could be interesting to
know if the kernel supports MPTCP or if MPTCP is "not allowed". I would
like to say that this new error is reported not because "the protocol
family is not available" but somehow, "not allowed" (EPERM?) to use it
if you see what I mean :)
But maybe this is not needed? Or recommended to anyway return EINVAL.

>> +static struct ctl_table mptcp_sysctl_table[] =3D {
>> +       {
>> +               .procname =3D "enabled",
>> +               .maxlen =3D sizeof(int),
>> +               .mode =3D 0644,
>> +               .proc_handler =3D proc_dointvec,
>> +       },
>> +       {}
>> +};
> =

> Should we prevent root processes that don't have the CAP_NET_ADMIN
> capability from setting net.mptcp.enabled, e.g. something like the
> following proc_dointvec() wrapper:

I don't know what are the best practices for that. But I am happy to
change if needed.

> static int mptcp_proc_dointvec(struct ctl_table *table, int write,
>                                 void __user *buffer, size_t *lenp, loff_t=
 *ppos)
> {
>         if (write && !capable(CAP_NET_ADMIN))
>                 return -EPERM;
> =

>         return proc_dointvec(table, write, buffer, lenp, ppos);
> }
> =

> I don't know if this works well for net namespaces, however.

We would need to use ns_capable(), we can pass extra data in the table
entry.

Cheers,
Matt

> =

> Thanks,
> -Ossama
> =


-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============5817521692815765825==--
