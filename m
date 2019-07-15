Content-Type: multipart/mixed; boundary="===============7165962446943893136=="
MIME-Version: 1.0
From: Othman, Ossama <ossama.othman at intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC PATCH] mptcp: new sysctl to control the activation
 per NS
Date: Mon, 15 Jul 2019 11:17:55 -0700
Message-ID: <CAPyD+=AL30XmZKiCLFhCV6wm9HDv0pmz_HE7paLcLpAkeXd2CA@mail.gmail.com>
In-Reply-To: 20190711190007.20106-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1492

--===============7165962446943893136==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Matthieu,

On Thu, Jul 11, 2019 at 12:01 PM Matthieu Baerts
<matthieu.baerts(a)tessares.net> wrote:
> For security reasons, it is interesting to have a global switch for
> MPTCP. To start, MPTCP will be disabled by default and only privileged
> users will be able to modify this. The reason is that because MPTCP is
> new, it will not be tested and reviewed by many and security issues can
> then take time to be discovered and fixed.

Do we need to be concerned about this new sysctl variable being used
to maliciously enable or disable MPTCP?

>     - In mptcp.org, all sysctls are prepended with 'mptcp_', e.g.
>       'net.mptcp.mptcp_enabled'. Do we need this? Is it better to keep the
>       same names if possible or better to differentiate? In this version,
>       'mptcp_' is not prepended.

The "mptcpd_" prefix seems redundant since the variable is already
part of the "net.mptcp" namespace.  If we're going to differentiate
sysctl interfaces between the two kernels, now is a good time to do so
given where we are in the upstream kernel development.

>     - ENOPROTOOPT is returned, maybe something else to return? EPERM is
>       maybe too generic? ENOTSUPP is not translated by perror().

ENOPROTOOPT appears to be more relevant to socket options, e.g. the
setsockopt(2) man page states the following:

       ENOPROTOOPT
                The option is unknown at the level indicated.

According to the socket(2) man page, EINVAL might be the better errno:

       EINVAL Unknown protocol, or protocol family not available.

> +static struct ctl_table mptcp_sysctl_table[] =3D {
> +       {
> +               .procname =3D "enabled",
> +               .maxlen =3D sizeof(int),
> +               .mode =3D 0644,
> +               .proc_handler =3D proc_dointvec,
> +       },
> +       {}
> +};

Should we prevent root processes that don't have the CAP_NET_ADMIN
capability from setting net.mptcp.enabled, e.g. something like the
following proc_dointvec() wrapper:

static int mptcp_proc_dointvec(struct ctl_table *table, int write,
                                void __user *buffer, size_t *lenp, loff_t *=
ppos)
{
        if (write && !capable(CAP_NET_ADMIN))
                return -EPERM;

        return proc_dointvec(table, write, buffer, lenp, ppos);
}

I don't know if this works well for net namespaces, however.

Thanks,
-Ossama

--===============7165962446943893136==--
