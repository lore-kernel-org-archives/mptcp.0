Content-Type: multipart/mixed; boundary="===============8323792825355155985=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 2/3] mptcp: use ipv6-specific proto struct
Date: Thu, 21 Nov 2019 15:14:59 +0100
Message-ID: <3e9f3743-2c9e-7c88-5940-77ae1f80157f@tessares.net>
In-Reply-To: 1b28dd4ca92f685c8782b2a9239a76074b041542.1574338647.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2647

--===============8323792825355155985==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 21/11/2019 13:25, Paolo Abeni wrote:
> Because it needs a different (greater) obj_size.
> =

> Squash-to: "mptcp: Add MPTCP socket stubs"
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>

[...]

> @@ -985,6 +986,11 @@ int mptcp_proto_v6_init(void)
>   {
>   	int err;
>   =

> +	mptcp_v6_prot =3D mptcp_prot;
> +	strcpy(mptcp_v6_prot.name, "TCPv6");

Should we call it "MPTCPv6" (mptcp_prot is called "MPTCP")

> +	mptcp_v6_prot.obj_size =3D sizeof(struct mptcp_sock) +
> +				 sizeof(struct ipv6_pinfo);

Very good catch!

Why did we not have the crash before?

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============8323792825355155985==--
