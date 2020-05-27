Content-Type: multipart/mixed; boundary="===============9153089899678532042=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 0/4] mptcp: token container refactor
Date: Wed, 27 May 2020 16:05:27 -0700
Message-ID: <alpine.OSX.2.22.394.2005271555540.6568@mjmartin-mac01.local>
In-Reply-To: cover.1590427813.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4517

--===============9153089899678532042==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi Paolo,

On Mon, 25 May 2020, Paolo Abeni wrote:

> This series supersede the RTC patch for token refactor. The relevant patch
> is unchanged, but this additional bring in some related minor cleanup
> (patch 1/4) and KUNIT (!!!) self-tests (4/4). To make things cleaner it a=
lso
> moves the existing in-kernel tests (crypto) to KUNIT.
>
> The most relevant changes from v1 are in patch 2/4.
>
> This addresses most of the issues raised by Christoph, Davide and Mat, wi=
th the
> notable exception of shirinking the hash table bucket size - I'm unable t=
o do
> that with the current fixes for the list curruption noted by Christoph.
>
> I hope the trade-off beween the self-contained fix and the avoided memory
> optimization is acceptable.
>
> Paolo Abeni (4):
>  mptcp: add __init annotation on setup functions
>  mptcp: refactor token container.
>  mptcp: move crypto test to KUNIT
>  mptcp: introduce token KUNIT self-tests
>

The series looks good to me. Is this something we should let bake in =

mptcp-next for a little bit or do you want to submit for net-next while =

it's still open?

I'm curious to see if there's any netdv pushback on the boot-time memory =

allocation.

--
Mat Martineau
Intel
--===============9153089899678532042==--
