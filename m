Content-Type: multipart/mixed; boundary="===============5571382854678311375=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 5/6] mptcp: avoid a few atomic ops in the
 rx path
Date: Mon, 30 Nov 2020 15:44:54 -0800
Message-ID: <e9ef28f7-814a-1a86-9337-a7d2eddb7754@linux.intel.com>
In-Reply-To: 46e049b7bf734ed50f5b3c3762ee0278a682c66e.1606413118.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6996

--===============5571382854678311375==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 27 Nov 2020, Paolo Abeni wrote:

> Extending the data_lock scope in mptcp_incoming_option
> we can use that to protect both snd_una and wnd_end.
> In the typical case, we will have a single atomic op instead of 2
>
> Acked-by: Florian Westphal <fw(a)strlen.de>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> net/mptcp/mptcp_diag.c |  2 +-
> net/mptcp/options.c    | 33 +++++++++++++--------------------
> net/mptcp/protocol.c   | 34 ++++++++++++++++------------------
> net/mptcp/protocol.h   |  8 ++++----
> 4 files changed, 34 insertions(+), 43 deletions(-)

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============5571382854678311375==--
