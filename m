Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA3D72
	for <mptcp@lists.linux.dev>; Tue, 11 May 2021 00:05:53 +0000 (UTC)
IronPort-SDR: f65Hx73aGRQLjy1nD1opjxGzKpNdN7Vg5d9sgS7MB/XrnFcHdLyvKr3nm1737wbGih/qQQCNaE
 yOSoCDh47aJA==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="284803881"
X-IronPort-AV: E=Sophos;i="5.82,288,1613462400"; 
   d="scan'208";a="284803881"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 17:05:52 -0700
IronPort-SDR: Tajuxp57WnREI8Stl/UxcEXy78I8F96japNmOuDRLuFhRAD3X+ELt/UYdMCbJviwwL6NWQ8nh7
 8lmfKpUCtjdw==
X-IronPort-AV: E=Sophos;i="5.82,288,1613462400"; 
   d="scan'208";a="609282417"
Received: from akalita-mobl1.amr.corp.intel.com ([10.209.125.201])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 17:05:52 -0700
Date: Mon, 10 May 2021 17:05:52 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Florian Westphal <fw@strlen.de>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 5/8] mptcp: setsockopt: handle SOL_SOCKET in
 one place only
In-Reply-To: <20210506102243.2390-6-fw@strlen.de>
Message-ID: <cef9b5-266f-ba1b-1c37-1758b8e211e2@linux.intel.com>
References: <20210506102243.2390-1-fw@strlen.de> <20210506102243.2390-6-fw@strlen.de>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 6 May 2021, Florian Westphal wrote:

> Move the pre-check to the function that handles all SOL_SOCKET
> values.
>
> At this point there is complete coverage for all values that have
> been accepted previously.
>
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
> net/mptcp/sockopt.c | 89 +++++++++++----------------------------------
> 1 file changed, 22 insertions(+), 67 deletions(-)
>
> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index 7b47204ecb9a..a83c0e4669d7 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -311,7 +311,8 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
> 	case SO_PREFER_BUSY_POLL:
> 	case SO_BUSY_POLL_BUDGET:
> 		/* No need to copy: only relevant for msk */
> -		break;
> +		return sock_setsockopt(sk->sk_socket, SOL_SOCKET, optname, optval, optlen);
> +
> 	case SO_NO_CHECK:
> 	case SO_DONTROUTE:
> 	case SO_BROADCAST:
> @@ -325,7 +326,24 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
> 		return 0;
> 	}
>
> -	return sock_setsockopt(sk->sk_socket, SOL_SOCKET, optname, optval, optlen);
> +	/* SO_OOBINLINE is not supported, let's avoid the related mess
> +	 * SO_ATTACH_FILTER, SO_ATTACH_BPF, SO_ATTACH_REUSEPORT_CBPF,
> +	 * SO_DETACH_REUSEPORT_BPF, SO_DETACH_FILTER, SO_LOCK_FILTER,
> +	 * we must be careful with subflows
> +	 *
> +	 * SO_ATTACH_REUSEPORT_EBPF is not supported, at it checks
> +	 * explicitly the sk_protocol field
> +	 *
> +	 * SO_PEEK_OFF is unsupported, as it is for plain TCP
> +	 * SO_MAX_PACING_RATE is unsupported, we must be careful with subflows
> +	 * SO_CNX_ADVICE is currently unsupported, could possibly be relevant,
> +	 * but likely needs careful design
> +	 *
> +	 * SO_ZEROCOPY is currently unsupported, TODO in sndmsg
> +	 * SO_TXTIME is currently unsupported
> +	 */
> +
> +	return -EOPNOTSUPP;
> }
>
> static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
> @@ -357,72 +375,9 @@ static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
>
> static bool mptcp_supported_sockopt(int level, int optname)
> {
> -	if (level == SOL_SOCKET) {
> -		switch (optname) {
> -		case SO_DEBUG:
> -		case SO_REUSEPORT:
> -		case SO_REUSEADDR:
> -
> -		/* the following ones need a better implementation,
> -		 * but are quite common we want to preserve them
> -		 */
> -		case SO_BINDTODEVICE:
> -		case SO_SNDBUF:
> -		case SO_SNDBUFFORCE:
> -		case SO_RCVBUF:
> -		case SO_RCVBUFFORCE:
> -		case SO_KEEPALIVE:
> -		case SO_PRIORITY:
> -		case SO_LINGER:
> -		case SO_TIMESTAMP_OLD:
> -		case SO_TIMESTAMP_NEW:
> -		case SO_TIMESTAMPNS_OLD:
> -		case SO_TIMESTAMPNS_NEW:
> -		case SO_TIMESTAMPING_OLD:
> -		case SO_TIMESTAMPING_NEW:
> -		case SO_RCVLOWAT:
> -		case SO_RCVTIMEO_OLD:
> -		case SO_RCVTIMEO_NEW:
> -		case SO_SNDTIMEO_OLD:
> -		case SO_SNDTIMEO_NEW:
> -		case SO_MARK:
> -		case SO_INCOMING_CPU:
> -		case SO_BINDTOIFINDEX:
> -		case SO_BUSY_POLL:
> -		case SO_PREFER_BUSY_POLL:
> -		case SO_BUSY_POLL_BUDGET:
> -
> -		/* next ones are no-op for plain TCP */
> -		case SO_NO_CHECK:
> -		case SO_DONTROUTE:
> -		case SO_BROADCAST:
> -		case SO_BSDCOMPAT:
> -		case SO_PASSCRED:
> -		case SO_PASSSEC:
> -		case SO_RXQ_OVFL:
> -		case SO_WIFI_STATUS:
> -		case SO_NOFCS:
> -		case SO_SELECT_ERR_QUEUE:
> -			return true;
> -		}
> +	if (level == SOL_SOCKET)
> +		return true; /* mptcp_setsockopt_sol_socket handles this */

I suggest not adding these two lines, and moving the call to 
mptcp_supported_sockopt() after the SOL_SOCKET handling at the beginning 
of mptcp_setsockopt(). What do you think?

Mat


>
> -		/* SO_OOBINLINE is not supported, let's avoid the related mess */
> -		/* SO_ATTACH_FILTER, SO_ATTACH_BPF, SO_ATTACH_REUSEPORT_CBPF,
> -		 * SO_DETACH_REUSEPORT_BPF, SO_DETACH_FILTER, SO_LOCK_FILTER,
> -		 * we must be careful with subflows
> -		 */
> -		/* SO_ATTACH_REUSEPORT_EBPF is not supported, at it checks
> -		 * explicitly the sk_protocol field
> -		 */
> -		/* SO_PEEK_OFF is unsupported, as it is for plain TCP */
> -		/* SO_MAX_PACING_RATE is unsupported, we must be careful with subflows */
> -		/* SO_CNX_ADVICE is currently unsupported, could possibly be relevant,
> -		 * but likely needs careful design
> -		 */
> -		/* SO_ZEROCOPY is currently unsupported, TODO in sndmsg */
> -		/* SO_TXTIME is currently unsupported */
> -		return false;
> -	}
> 	if (level == SOL_IP) {
> 		switch (optname) {
> 		/* should work fine */
> -- 
> 2.26.3
>
>
>

--
Mat Martineau
Intel
