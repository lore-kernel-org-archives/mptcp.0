Content-Type: multipart/mixed; boundary="===============5472328455530971847=="
MIME-Version: 1.0
From: Christoph Hellwig <hch at lst.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 25/26] net: pass a sockptr_t into ->setsockopt
Date: Fri, 07 Aug 2020 09:21:20 +0200
Message-ID: <20200807072120.GB2086@lst.de>
In-Reply-To: 6357942b-0b6e-1901-7dce-e308c9fac347@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5506

--===============5472328455530971847==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 06, 2020 at 03:21:25PM -0700, Eric Dumazet wrote:
> converting get_user(...)   to  copy_from_sockptr(...) really assumed the =
optlen
> has been validated to be >=3D sizeof(int) earlier.
> =

> Which is not always the case, for example here.

Yes.  And besides the bpfilter mess the main reason I even had to add
the sockptr vs just copying optlen in the high-level socket code.

Please take a look at the patch in the other thread to just revert to
the "dumb" version everywhere.
--===============5472328455530971847==--
