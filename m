Content-Type: multipart/mixed; boundary="===============0634231394426604587=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next] Squash-to: "mptcp: refactor shutdown and
 close"
Date: Thu, 15 Oct 2020 16:54:11 -0700
Message-ID: <cf16af4-8fec-b19e-9117-c6952f974f9c@linux.intel.com>
In-Reply-To: fffd74384126974bb9f56303948000f11b0b291f.1602794093.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6323

--===============0634231394426604587==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Thu, 15 Oct 2020, Paolo Abeni wrote:

> After the refactor __mptcp_close_ssk() can be invoked on
> orphaned TCP socket, so we can't wait a timeout, or
> sk_stream_wait_close() will oops due to NULL waitqueue.
>
> We can simply always use a 0 timeout (and clean-up the
> related signature accordingly): the timeout, if any,
> is used before by mptcp_close().
>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> This should fix issue 100, but I only build test it ;)
> ---
> net/mptcp/pm_netlink.c |  6 ++----
> net/mptcp/protocol.c   | 19 +++++++++----------
> net/mptcp/protocol.h   |  3 +--
> 3 files changed, 12 insertions(+), 16 deletions(-)

Looks good to me from a code review perspective. I haven't confirmed that =

it fixes #100.


--
Mat Martineau
Intel
--===============0634231394426604587==--
