Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B1470
	for <mptcp@lists.linux.dev>; Tue, 30 Mar 2021 00:50:39 +0000 (UTC)
IronPort-SDR: zfZxuz+kU2jdWNxI//ka+wXZ2M3rCFcQM6pyu54zUQ05Z6P2BcBEtetBuJobYLbZIy8pFpRF8D
 HqZTD+iA3bRg==
X-IronPort-AV: E=McAfee;i="6000,8403,9938"; a="171058137"
X-IronPort-AV: E=Sophos;i="5.81,289,1610438400"; 
   d="scan'208";a="171058137"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 17:50:38 -0700
IronPort-SDR: o0HQyQbvKFqzQphn5WiQtJHIjK37ChtkuS5DRWl1IZmnf8SbB2r6LZNnPX98dyp8FYdhvR7mUK
 qpL2yIXp3FYg==
X-IronPort-AV: E=Sophos;i="5.81,289,1610438400"; 
   d="scan'208";a="417918211"
Received: from erwebste-mobl.amr.corp.intel.com ([10.251.11.21])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 17:50:38 -0700
Date: Mon, 29 Mar 2021 17:50:38 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: mptcp@lists.linux.dev
Subject: Re: [MPTCP][PATCH v2 mptcp-next 15/16] selftests: mptcp: enable
 checksum in mptcp_connect.sh
In-Reply-To: <fa2e5e2e8eee03798175cc42e73810518b47d29b.1617014019.git.geliangtang@gmail.com>
Message-ID: <8d76529e-563b-9c10-fbba-5bafbfbbe5e1@linux.intel.com>
References: <cover.1617014019.git.geliangtang@gmail.com> <08ab4ce9f13e954b45d24c9e7842f7a6a9798d54.1617014019.git.geliangtang@gmail.com> <d8a242cfe08b2ab0ccb4752a15c8ea8ef0226ac1.1617014019.git.geliangtang@gmail.com>
 <1c0a240472edcc1afbcb822bd9af3cf03800759e.1617014019.git.geliangtang@gmail.com> <4c7e346e9d1005e8838dd8cf742d8324ef7553c0.1617014019.git.geliangtang@gmail.com> <4a289b981d90fcfda872ade12ec94d27d47bc01f.1617014019.git.geliangtang@gmail.com>
 <07856073b42a0343f81e6b6e468d6965b693fc5d.1617014019.git.geliangtang@gmail.com> <95dff6615e84496cab649de3d74917790f6a571f.1617014019.git.geliangtang@gmail.com> <44262de5d6a76c02e585ba148117af9b81355d0d.1617014019.git.geliangtang@gmail.com>
 <5364f608199436bf7125d8f89a4fefcaad2b5eb3.1617014019.git.geliangtang@gmail.com> <c231d3aa6b38374c1e28709e4d4b94e179c6e13c.1617014019.git.geliangtang@gmail.com> <fa2e5e2e8eee03798175cc42e73810518b47d29b.1617014019.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 29 Mar 2021, Geliang Tang wrote:

> This patch added a new argument "C" for mptcp_connect.sh script to
> set the sysctl checksum_enabled to 1 to enable the data checksum.
>
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>

In addition to the "-C" flag for adding checksums to most test cases, it 
would help to have a few more test cases added that verify the checksum 
handshake:

  * Sender and listener both have checksums off
  * Sender and listener both have checksums on
  * Sender checksums off, listener checksums on
  * Sender checksums on, listener checksums off

Those could run the same with or without "-C", but the rest of the tests 
would only enable checksums when "-C" was used.


Thanks,

Mat


> ---
> tools/testing/selftests/net/mptcp/mptcp_connect.sh | 13 ++++++++++++-
> 1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> index 385cdc98aed8..c769f1e962bd 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> @@ -3,7 +3,7 @@
>
> time_start=$(date +%s)
>
> -optstring="S:R:d:e:l:r:h4cm:f:t"
> +optstring="S:R:d:e:l:r:h4cm:f:tC"
> ret=0
> sin=""
> sout=""
> @@ -22,6 +22,7 @@ sndbuf=0
> rcvbuf=0
> options_log=true
> do_tcp=0
> +checksum=false
> filesize=0
>
> if [ $tc_loss -eq 100 ];then
> @@ -47,6 +48,7 @@ usage() {
> 	echo -e "\t-R: set rcvbuf value (default: use kernel default)"
> 	echo -e "\t-m: test mode (poll, sendfile; default: poll)"
> 	echo -e "\t-t: also run tests with TCP (use twice to non-fallback tcp)"
> +	echo -e "\t-C: enable the MPTCP data checksum"
> }
>
> while getopts "$optstring" option;do
> @@ -104,6 +106,9 @@ while getopts "$optstring" option;do
> 	"t")
> 		do_tcp=$((do_tcp+1))
> 		;;
> +	"C")
> +		checksum=true
> +		;;
> 	"?")
> 		usage $0
> 		exit 1
> @@ -200,6 +205,12 @@ ip -net "$ns4" route add default via dead:beef:3::2
> # use TCP syn cookies, even if no flooding was detected.
> ip netns exec "$ns2" sysctl -q net.ipv4.tcp_syncookies=2
>
> +if $checksum; then
> +	for i in "$ns1" "$ns2" "$ns3" "$ns4";do
> +		ip netns exec $i sysctl -q net.mptcp.checksum_enabled=1
> +	done
> +fi
> +
> set_ethtool_flags() {
> 	local ns="$1"
> 	local dev="$2"
> -- 
> 2.30.2
>
>
>

--
Mat Martineau
Intel
