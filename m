Content-Type: multipart/mixed; boundary="===============0393722791776022266=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 0/6] IPv6 support
Date: Wed, 06 Nov 2019 10:04:49 +0100
Message-ID: <0a844a87aa4f8a2e214ba7e6c76092c98fd434a0.camel@redhat.com>
In-Reply-To: 20191106044133.14418-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2421

--===============0393722791776022266==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-11-05 at 20:41 -0800, Peter Krystad wrote:
> Implemented support for IPv6. selftests pass with ipv6=3Dtrue, but
> they take twice as long to run...
> =

> With re-factoring the addition of IPv6 is very clean =


Indeed.

> but I did not
> split files yet as it will be hard to squash any changes after the
> such a split.

I think this is ok.

The series looks great, with a minor comment on patch 5.

Cheers,

Paolo

--===============0393722791776022266==--
