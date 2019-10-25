Content-Type: multipart/mixed; boundary="===============3335246729536278451=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v4 0/9] selftests: add ipv6 support and reduce run
 time
Date: Fri, 25 Oct 2019 16:38:28 -0700
Message-ID: <alpine.OSX.2.21.1910251635380.66912@srpullel-mobl.amr.corp.intel.com>
In-Reply-To: 20191025121651.25946-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2328

--===============3335246729536278451==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Fri, 25 Oct 2019, Florian Westphal wrote:

> This is the 4th iteration of the selftest patchset.
>
> Changes since v3:
> - get rid of unused variable warnings in patch 2
> - get rid of bogus fallthrough in patch 4
> - add patch 8: Get rid of redundant test cases, no need to
>   test tcp fallback for all netns combinations.
> - add patch 9: allow to set delay/loss/reordering etc. to use.
>   Default is random so selftests expose wider combinations.
>
> All changes can be squashed into "mptcp: add basic kselftest for mptcp".
>

I think 1-8 are ready to merge, and patch 9 in combination with my capture =

fix - if that works for Matthieu & Florian.

--
Mat Martineau
Intel
--===============3335246729536278451==--
