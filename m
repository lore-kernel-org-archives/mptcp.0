Content-Type: multipart/mixed; boundary="===============4894522799573545594=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next] mptcp: skip to next candidate if
 subflow has unacked data
Date: Thu, 08 Oct 2020 15:36:58 -0700
Message-ID: <alpine.OSX.2.23.453.2010081452440.49214@ozore-mobl2.amr.corp.intel.com>
In-Reply-To: 20201001081406.4548-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 6259

--===============4894522799573545594==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Thu, 1 Oct 2020, Florian Westphal wrote:

> In case a subflow path is blocked, MPTCP-level retransmit may not take
> place anymore because such subflow is likely to have unacked data left
> in its write queue.
>
> Ignore subflows that have experienced loss and test next candidate.
>
> Fixes: 3b1d6210a95773691 ("mptcp: implement and use MPTCP-level retransmi=
ssion")
> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---
> net/mptcp/protocol.c | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 7aa52a3bc5e2..0266d8ac24d2 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1732,8 +1732,11 @@ static struct sock *mptcp_subflow_get_retrans(cons=
t struct mptcp_sock *msk)
> 			continue;
>
> 		/* still data outstanding at TCP level?  Don't retransmit. */
> -		if (!tcp_write_queue_empty(ssk))
> +		if (!tcp_write_queue_empty(ssk)) {
> +			if (inet_csk(ssk)->icsk_ca_state >=3D TCP_CA_Loss)
> +				continue;
> 			return NULL;
> +		}
>
> 		if (subflow->backup) {
> 			if (!backup)
> -- =

> 2.26.2

Checking for the loss state is an improvement when the first subflow in =

the list is blocking retransmissions, looks like a good idea to me.

We can still get inconsistent retransmission behavior depending on the =

order of subflows in the list - if the first non-loss subflow has an empty =

write queue then retransmission will happen even if other subflows have =

queued data. I suppose this causes the opposite problem, retransmitting =

when it should wait. Better to handle a fix for that separately?

--
Mat Martineau
Intel
--===============4894522799573545594==--
