Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268127C
	for <mptcp@lists.linux.dev>; Sat, 11 Jun 2022 00:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654905909; x=1686441909;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=D6R6id7qn0bhSaSAtTtPR3K8G0VK697t3i/IkZz6bjI=;
  b=Q31Zf/RbaSmocYxg+bW37RLgIva8TpSCqtDtOqFaD9Z7ruiedf0oQq9m
   eo9rAGfZvv8agVCunVwUIyXYDk9ye7EpKAioAJJc6qOrB5QpG+blZcIWo
   wieMug432YQ6clvMiL8tk03hxjRlkIBxZ1xiUmhiRePyXAPxDTCFxhnQx
   jPe8NaPN5gC69LXrcvH5GcHD07I2H18ZLLstYZh+BfJJ5DwkjXyZyF8ww
   a02O/915nliY+cX/eYIPtJk3RrZV41xeyypuK1g0gn7EAxupzqg09cL1m
   cnxo0XWO2xZY8jdfWb+hjsaRr9Z8ZKUMFHInZaom6Y7tTlX1ChHDxa/LA
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10374"; a="339535481"
X-IronPort-AV: E=Sophos;i="5.91,291,1647327600"; 
   d="scan'208";a="339535481"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 17:04:58 -0700
X-IronPort-AV: E=Sophos;i="5.91,291,1647327600"; 
   d="scan'208";a="567052011"
Received: from efbarbud-mobl1.amr.corp.intel.com (HELO csouzax-mobl2.amr.corp.intel.com) ([10.212.104.59])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 17:04:58 -0700
Date: Fri, 10 Jun 2022 17:04:57 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] selftests: mptcp: avoid Terminated messages
 in userspace_pm
In-Reply-To: <829ce50fa6d830c6c5ed371e7741b6d30792d905.1654829977.git.geliang.tang@suse.com>
Message-ID: <e28c91e-c12-ae33-2249-68faef292410@linux.intel.com>
References: <829ce50fa6d830c6c5ed371e7741b6d30792d905.1654829977.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 10 Jun 2022, Geliang Tang wrote:

> There're some 'Terminated' messages in the output of userspace pm tests
> script after killing './pm_nl_ctl events' processes:
>
> Created network namespaces ns1, ns2         			[OK]
> ./userspace_pm.sh: line 166: 13735 Terminated              ip netns exec "$ns2" ./pm_nl_ctl events >> "$client_evts" 2>&1
> ./userspace_pm.sh: line 172: 13737 Terminated              ip netns exec "$ns1" ./pm_nl_ctl events >> "$server_evts" 2>&1
> Established IPv4 MPTCP Connection ns2 => ns1    		[OK]
> ./userspace_pm.sh: line 166: 13753 Terminated              ip netns exec "$ns2" ./pm_nl_ctl events >> "$client_evts" 2>&1
> ./userspace_pm.sh: line 172: 13755 Terminated              ip netns exec "$ns1" ./pm_nl_ctl events >> "$server_evts" 2>&1
> Established IPv6 MPTCP Connection ns2 => ns1    		[OK]
> ADD_ADDR 10.0.2.2 (ns2) => ns1, invalid token    		[OK]
>
> This patch adds 'wait $pid 2>/dev/null' commands after 'kill $pid'
> to avoid printing out these Terminated messages.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>

Looks good to me, thanks Geliang:

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>


> ---
> .../testing/selftests/net/mptcp/userspace_pm.sh | 17 +++++++++++++++++
> 1 file changed, 17 insertions(+)
>
> diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
> index 78d0bb640b11..eaa54c3f75fb 100755
> --- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
> +++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
> @@ -49,15 +49,18 @@ cleanup()
> 	fi
> 	if [ $server4_pid -ne 0 ]; then
> 		kill $server4_pid > /dev/null 2>&1
> +		wait $server4_pid 2>/dev/null
> 	fi
> 	if [ $client6_pid -ne 0 ]; then
> 		kill -SIGUSR1 $client6_pid > /dev/null 2>&1
> 	fi
> 	if [ $server6_pid -ne 0 ]; then
> 		kill $server6_pid > /dev/null 2>&1
> +		wait $server6_pid 2>/dev/null
> 	fi
> 	if [ $evts_pid -ne 0 ]; then
> 		kill $evts_pid > /dev/null 2>&1
> +		wait $evts_pid 2>/dev/null
> 	fi
> 	local netns
> 	for netns in "$ns1" "$ns2" ;do
> @@ -154,6 +157,7 @@ make_connection()
>
> 	# Capture client/server attributes from MPTCP connection netlink events
> 	kill $client_evts_pid
> +	wait $client_evts_pid 2>/dev/null
>
> 	local client_token
> 	local client_port
> @@ -166,6 +170,7 @@ make_connection()
> 	client_serverside=$(sed --unbuffered -n 's/.*\(server_side:\)\([[:digit:]]*\).*$/\2/p;q'\
> 				      "$client_evts")
> 	kill $server_evts_pid
> +	wait $server_evts_pid 2>/dev/null
> 	server_token=$(sed --unbuffered -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$server_evts")
> 	server_serverside=$(sed --unbuffered -n 's/.*\(server_side:\)\([[:digit:]]*\).*$/\2/p;q'\
> 				      "$server_evts")
> @@ -287,6 +292,7 @@ test_announce()
> 			      "$client_addr_id" "$new4_port"
>
> 	kill $evts_pid
> +	wait $evts_pid 2>/dev/null
>
> 	# Capture events on the network namespace running the client
> 	:>"$evts"
> @@ -322,6 +328,7 @@ test_announce()
> 			      "$server_addr_id" "$new4_port"
>
> 	kill $evts_pid
> +	wait $evts_pid 2>/dev/null
> 	rm -f "$evts"
> }
>
> @@ -417,6 +424,7 @@ test_remove()
> 	verify_remove_event "$evts" "$REMOVED" "$server6_token" "$client_addr_id"
>
> 	kill $evts_pid
> +	wait $evts_pid 2>/dev/null
>
> 	# Capture events on the network namespace running the client
> 	:>"$evts"
> @@ -450,6 +458,7 @@ test_remove()
> 	verify_remove_event "$evts" "$REMOVED" "$client6_token" "$server_addr_id"
>
> 	kill $evts_pid
> +	wait $evts_pid 2>/dev/null
> 	rm -f "$evts"
> }
>
> @@ -554,6 +563,7 @@ test_subflows()
>
> 	# Delete the listener from the client ns, if one was created
> 	kill $listener_pid > /dev/null 2>&1
> +	wait $listener_pid 2>/dev/null
>
> 	local sport
> 	sport=$(sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts")
> @@ -593,6 +603,7 @@ test_subflows()
>
> 	# Delete the listener from the client ns, if one was created
> 	kill $listener_pid > /dev/null 2>&1
> +	wait $listener_pid 2>/dev/null
>
> 	sport=$(sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts")
>
> @@ -632,6 +643,7 @@ test_subflows()
>
> 	# Delete the listener from the client ns, if one was created
> 	kill $listener_pid > /dev/null 2>&1
> +	wait $listener_pid 2>/dev/null
>
> 	sport=$(sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts")
>
> @@ -648,6 +660,7 @@ test_subflows()
> 	   "$client4_token" > /dev/null 2>&1
>
> 	kill $evts_pid
> +	wait $evts_pid 2>/dev/null
>
> 	# Capture events on the network namespace running the client
> 	:>"$evts"
> @@ -675,6 +688,7 @@ test_subflows()
>
> 	# Delete the listener from the server ns, if one was created
> 	kill $listener_pid> /dev/null 2>&1
> +	wait $listener_pid 2>/dev/null
>
> 	sport=$(sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts")
>
> @@ -714,6 +728,7 @@ test_subflows()
>
> 	# Delete the listener from the server ns, if one was created
> 	kill $listener_pid > /dev/null 2>&1
> +	wait $listener_pid 2>/dev/null
>
> 	sport=$(sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts")
>
> @@ -751,6 +766,7 @@ test_subflows()
>
> 	# Delete the listener from the server ns, if one was created
> 	kill $listener_pid > /dev/null 2>&1
> +	wait $listener_pid 2>/dev/null
>
> 	sport=$(sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts")
>
> @@ -767,6 +783,7 @@ test_subflows()
> 	   "$server4_token" > /dev/null 2>&1
>
> 	kill $evts_pid
> +	wait $evts_pid 2>/dev/null
> 	rm -f "$evts"
> }
>
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
