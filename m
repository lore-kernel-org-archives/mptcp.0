Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CBB70
	for <mptcp@lists.linux.dev>; Thu,  3 Jun 2021 11:45:51 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1lolXE-00065e-81; Thu, 03 Jun 2021 13:29:12 +0200
Date: Thu, 3 Jun 2021 13:29:12 +0200
From: Florian Westphal <fw@strlen.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev, fwestpha@redhat.com
Subject: Re: [PATCH mptcp-net] selftests: mptcp: enable syncookie only in
 absence of reorders
Message-ID: <20210603112912.GA7062@breakpoint.cc>
References: <15333b645caafe2b7fbb028e67bb788c0d5cf526.1622719000.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15333b645caafe2b7fbb028e67bb788c0d5cf526.1622719000.git.pabeni@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Paolo Abeni <pabeni@redhat.com> wrote:
> Syncookie validation may fail for OoO packets, causing spurious
> resets and self-tests failures, so let's force syncookie only
> for tests iteration with no OoO.
> 
> Fixes: fed61c4b584c ("selftests: mptcp: make 2nd net namespace use tcp syn cookies unconditionally")
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/198
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_connect.sh | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> index 69351c3eb68c..9e53334c9512 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> @@ -202,9 +202,6 @@ ip -net "$ns4" link set ns4eth3 up
>  ip -net "$ns4" route add default via 10.0.3.2
>  ip -net "$ns4" route add default via dead:beef:3::2
>  
> -# use TCP syn cookies, even if no flooding was detected.
> -ip netns exec "$ns2" sysctl -q net.ipv4.tcp_syncookies=2
> -
>  if $checksum; then
>  	for i in "$ns1" "$ns2" "$ns3" "$ns4";do
>  		ip netns exec $i sysctl -q net.mptcp.checksum_enabled=1
> @@ -748,6 +745,13 @@ for sender in $ns1 $ns2 $ns3 $ns4;do
>  		exit $ret
>  	fi
>  
> +	# force TCP syn cookies only if there is no reorder
> +	if [ $sender = $ns1 ]; then
> +		ip netns exec "$ns2" sysctl -q net.ipv4.tcp_syncookies=2

I wasn't clear to me at first glance what $sender = $ns1 had to
do with reordering.

Maybe:

# ns1<->ns2 is not subject to reordering/tc delays.  Use it to test
# mptcp syncookie support.

?
