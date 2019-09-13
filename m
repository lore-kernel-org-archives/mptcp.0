Content-Type: multipart/mixed; boundary="===============0558062221792003464=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH selftests 3/5] selftests: mptcp: add
 accept/getpeername checks
Date: Fri, 13 Sep 2019 12:13:09 +0200
Message-ID: <20190913101309.GA10656@breakpoint.cc>
In-Reply-To: 20190913094528.3163-4-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 1843

--===============0558062221792003464==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Florian Westphal <fw(a)strlen.de> wrote:
> +static void check_getpeername_connect(int fd)
> +{
> +	struct sockaddr_storage ss;
> +	socklen_t salen =3D sizeof(ss);
> +
> +	if (getpeername(fd, (struct sockaddr *)&ss, &salen)) {
> +		char a[INET6_ADDRSTRLEN];
> +		char b[INET6_ADDRSTRLEN];

Grrr.  This is not what I intended.

Instead of sending a v2, you could also pull the series (with the above
fixed) via

git pull git://git.breakpoint.cc/fw/mptcp-next.git selftests_13092019

Otherwise I can just send a v2.  Let me know, thanks.

--===============0558062221792003464==--
