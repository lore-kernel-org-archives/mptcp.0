Content-Type: multipart/mixed; boundary="===============3271696849466581076=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next v2] selftests: mptcp: add link failure
 test case
Date: Sat, 24 Oct 2020 12:05:17 +0200
Message-ID: <76abec4c-0056-e328-682c-ad135b979613@tessares.net>
In-Reply-To: 20201009151117.6672-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 6429

--===============3271696849466581076==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On 09/10/2020 17:11, Florian Westphal wrote:
> Add a test case where a link fails with multiple subflows.
> The expectation is that MPTCP will transmit any data that
> could not be delivered via the failed link on another subflow.

Thank you for these modifications!

(...)

> @@ -279,14 +308,32 @@ run_tests()
>   	listener_ns=3D"$1"
>   	connector_ns=3D"$2"
>   	connect_addr=3D"$3"
> -	rm_nr_ns1=3D"${4:-0}"
> -	rm_nr_ns2=3D"${5:-0}"
> -	speed=3D"${6:-fast}"
> +	test_linkfail=3D"$4"
> +	rm_nr_ns1=3D"${5:-0}"
> +	rm_nr_ns2=3D"${6:-0}"
> +	speed=3D"${7:-fast}"
>   	lret=3D0
> +	oldin=3D""
> +
> +	if [ "$test_linkfail" -eq 1 ];then
> +		size=3D$((RANDOM%1024))
> +		size=3D$((size+1))
> +		size=3D$((size*128)) > +
> +		oldin=3D$(mktemp)
> +		cp "$cin" "$oldin"
> +		make_file "$cin" "client" $size
This will create one file up to 1024*128 KB =3D ~131MB when later using =

this command:


   dd if=3D/dev/urandom of=3D"$name" bs=3D1024 count=3D$size


This file will be duplicated a few times later when doing the transfer:


   ( cat "$cin" ; (...) ; cat "$cin" ) | \
       tee "$cinsent" | \
       (...) $mptcp_connect (...) > "$cout"


If I am not mistaken, we then have:

- $cin =3D max 131MB: initial file
- $cinsent =3D 2 times $cin
- $sout =3D $cinsent

=E2=86=92 total: 5*$cin =3D max 655MB

Was it the intension? Could we reduce the maximum size while keeping the =

test valid?

On my side, /tmp is mounted in tmpfs and currently limited to 490M. Just =

to know if I need to increase the size of modify the selftest script :)

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============3271696849466581076==--
