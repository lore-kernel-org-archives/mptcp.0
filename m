Content-Type: multipart/mixed; boundary="===============6995837002504971927=="
MIME-Version: 1.0
From: Krystad, Peter <peter.krystad at intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH mptcp 0/3] mptcp: plug mptcp_accept memory leaks
Date: Mon, 13 May 2019 23:47:59 +0000
Message-ID: <afc4701d3b85b59693db097aa53b4ccac22c44c1.camel@intel.com>
In-Reply-To: 20190513122141.25396-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 1155

--===============6995837002504971927==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi Florian -

Thanks for this, it looks good to me with just one small comment on #2.

Peter.


On Mon, 2019-05-13 at 14:21 +0200, Florian Westphal wrote:
> Hi,
> =

> This series resolves the memory leaks that occur when running
> mptcp_connect.sh.
> =

> I don't mind if they get squashed.
> I've decided to split this into 3 distinct changes to make it
> a bit clearer what is going on.
> =

> Second patch is not a bug fix, i can resend and drop it if
> the consensus is to continue using the sk->sk_socket back reference.
> =

> Third patch is a bit large due to the change in how the new mptcp
> socket is created.
> =

> See the commit messages for more details.
> After these changes kmemleak doesn't report any leaks when the
> test script has completed.
> =

> Cheers,
> Florian
> =

> =

> _______________________________________________
> mptcp mailing list
> mptcp(a)lists.01.org
> https://lists.01.org/mailman/listinfo/mptcp

--===============6995837002504971927==--
