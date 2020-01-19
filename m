Content-Type: multipart/mixed; boundary="===============5709638901725056494=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] Move subflow ipv6 code earlier in subflow.c
Date: Sun, 19 Jan 2020 15:10:09 +0100
Message-ID: <c4b67714d7dc21e184e02570c7ebd1468c470baf.camel@redhat.com>
In-Reply-To: 20200118005811.20655-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3423

--===============5709638901725056494==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-01-17 at 16:58 -0800, Mat Martineau wrote:
> This prevents some diff noise in "mptcp: Implement MPTCP receive path",
> where the code is currently moved.
> =

> squashto: "mptcp: Handle MP_CAPABLE options for outgoing connections"
> =

> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

LGTM! yep, noise in later patch make the latter much less unreadable.

Thanks for addressing that!

Paolo

--===============5709638901725056494==--
