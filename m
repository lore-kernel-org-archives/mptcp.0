Content-Type: multipart/mixed; boundary="===============0444671260854701728=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC PATCH] mptcp:pm: sysctl to announce an addr
Date: Fri, 23 Aug 2019 15:55:43 +0200
Message-ID: <20190823135543.GL20113@breakpoint.cc>
In-Reply-To: 0906c889458e3d33596b978188c8cb3e8b028aa2.camel@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1687

--===============0444671260854701728==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Peter Krystad <peter.krystad(a)linux.intel.com> wrote:
> =

> Hi Matthieu -
> =

> Thanks for this patch, I tested it in my setup and it works fine except f=
or
> the endianess issue noted below.

[..]

> > +	if (in4_pton(addr, -1, (u8 *)&pernet->announce_v4_addr.s_addr, '\0',
> > +		     NULL) > 0) {
> =

> pm_announce_addr() [and code for OPTION_MPTCP_ADD_ADDR in
> mptcp_write_options()] is expecting this address to be in host byte order=
. We
> used host byte order for everything in mptcp_pm_data and subflow_context.
> In my tests the address is reversed in the ADD_ADDR option over the wire..

That looks like a bug in pm and options however -- when I see a struct
inaddr I expect it to store network byte order.

So, either those should use u32, or pm/option handling should assume
network byte order, i.e.:

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 4a9aac4710be..9f892478d336 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -603,7 +603,7 @@ void mptcp_write_options(__be32 *ptr, struct mptcp_out_=
options *opts)
        if (OPTION_MPTCP_ADD_ADDR & opts->suboptions) {
                *ptr++ =3D mptcp_option(MPTCPOPT_ADD_ADDR, TCPOLEN_MPTCP_AD=
D_ADDR,
                                      MPTCP_ADDR_IPVERSION_4, opts->addr_id=
);
-               *ptr++ =3D htonl(opts->addr.s_addr);
+               *ptr++ =3D opts->addr.s_addr;
        }
 =

 #if IS_ENABLED(CONFIG_IPV6)
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 501ff67284a4..32be34a5f951 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -93,7 +93,7 @@ int pm_create_subflow(u32 token, u8 remote_id)
 =

        remote.sin_family =3D msk->pm.remote_family;
        remote.sin_port =3D htons(msk->dport);
-       remote.sin_addr.s_addr =3D htonl(msk->pm.remote_addr.s_addr);
+       remote.sin_addr =3D msk->pm.remote_addr;
 =

        err =3D subflow_connect((struct sock *)msk, &local, &remote, remote=
_id);
 =



The ipv6 ADD_ADDR handling uses memcpy, so assumes network
byte order, so I think the above makes more sense than to tweak
Mathieus patch (thanks!).

--===============0444671260854701728==--
