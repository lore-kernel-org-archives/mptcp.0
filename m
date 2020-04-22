Content-Type: multipart/mixed; boundary="===============7161656545846541356=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v3 2/4] add support for mptcp netlink interface
Date: Wed, 22 Apr 2020 16:48:05 +0200
Message-ID: <d410c3e7-5d6b-fa5f-cbab-28e35bede31e@tessares.net>
In-Reply-To: 3d606c7f3644e756bc4c91f1eeca386374facca5.1587139599.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4226

--===============7161656545846541356==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

Thank you for the v3!

On 17/04/2020 18:08, Paolo Abeni wrote:
> diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
> new file mode 100644
> index 00000000..c2122790
> --- /dev/null
> +++ b/ip/ipmptcp.c
> @@ -0,0 +1,436 @@

(...)

> +static int mptcp_parse_limit(int argc, char **argv, struct nlmsghdr *n)
> +{
> +	bool set_rcv_add_addrs =3D false;
> +	bool set_subflows =3D false;
> +	__u32 rcv_add_addrs =3D 0;
> +	__u32 subflows =3D 0;
> +
> +	while (argc > 0) {
> +		if (matches(*argv, "subflows") =3D=3D 0) {
> +			NEXT_ARG();
> +
> +			if (get_u32(&subflows, *argv, 0))
> +				invarg("invalid subflows\n", *argv);
> +			set_subflows =3D true;
> +		} else if (matches(*argv, "add_addr_accepted") =3D=3D 0) {
> +			NEXT_ARG();
> +
> +			if (get_u32(&rcv_add_addrs, *argv, 0))
> +				invarg("invalid add_addr_accepted\n", *argv);
> +			set_rcv_add_addrs =3D true;
> +		} else {
> +			invarg("unknown", *argv);

I was going to add a detail here: "\n" seems missing but I just noticed =

it is always added in a few files I opened but not everywhere. =

Apparently, there is a mix usage:

  $ git grep -e "invarg(\".*);$" -- ip/ip*.c | wc -l
  359
  $ git grep -e "invarg(\".*);$" -- ip/ip*.c | grep -c '\\n"'
  161

So I am fine with or without this \n here and above where invarg() is used.


But maybe should we have: "unknown limit"? Up to you!

Of course no need to send a v4 just for that ;-)

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============7161656545846541356==--
