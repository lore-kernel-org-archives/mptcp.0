Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D95F7E3
	for <mptcp@lists.linux.dev>; Fri,  6 Jan 2023 01:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672967964; x=1704503964;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=rj0yu+HqNcasieTVYngOTtMcEMDIWdkOKITRpskCjwA=;
  b=RYUgBgWKqhIpnS3sv2GRFngxRaqX6wnSBNTVOi4Pg8eBAVhMm38Aq1N3
   pLfPwockUE7708SEf1Pr5emsH08DadoduNsyp32hDLCsRk54xSS7DlOib
   tu3jWMob+JFb6H+EX7baRsgiGDaGOjlz9k+0Kyv9r35sr9OA5+W56/UL9
   /Xnx/2tw76YlSWHeEWgIu/oGJhrJ2bOk3E1C8HDIjTZYX9Be7rn8NO4K6
   gMNJxg5881/4xBZI9Corou1DWpekIoA6tIAaSpRMh1nXrae7P5Puqk7hg
   8VcEjBZr9964K0Qh5D73kgSVw2eYYRQIqF/rZdGKpgYh2gLrgkmPRdiwU
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="310160462"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="310160462"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 17:19:23 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="605750904"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="605750904"
Received: from bkrishn1-mobl.amr.corp.intel.com ([10.251.16.148])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 17:19:23 -0800
Date: Thu, 5 Jan 2023 17:19:23 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v5 09/12] selftests: mptcp: userspace: print
 titles
In-Reply-To: <20230104171526.1416746-10-matthieu.baerts@tessares.net>
Message-ID: <a684ae0c-060c-49ae-f3a4-ec0a26dd0e21@linux.intel.com>
References: <20230104171526.1416746-1-matthieu.baerts@tessares.net> <20230104171526.1416746-10-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 4 Jan 2023, Matthieu Baerts wrote:

> This script is running a few tests after having setup the environment.
>
> Printing titles helps understand what is being tested.
>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
>
> Notes:
>    v3->v4:
>      - Add a title for the Cleanup (+ 'Done' at the end)
>
> .../selftests/net/mptcp/userspace_pm.sh       | 24 ++++++++++++++++++-
> 1 file changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
> index ab2d581f28a1..f9a03e6e968f 100755
> --- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
> +++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
> @@ -43,6 +43,11 @@ rndh=$(printf %x "$sec")-$(mktemp -u XXXXXX)
> ns1="ns1-$rndh"
> ns2="ns2-$rndh"
>
> +print_title()
> +{
> +	stdbuf -o0 -e0 printf "\t%s:\n" "${1}"

The indented titles seem kind of inverted to me:

"""
 	Init:
Created network namespaces ns1, ns2         			[OK]
 	Make connections:
Established IPv4 MPTCP Connection ns2 => ns1    		[OK]
Established IPv6 MPTCP Connection ns2 => ns1    		[OK]
 	Announce tests:
ADD_ADDR 10.0.2.2 (ns2) => ns1, invalid token    		[OK]
ADD_ADDR id:55 10.0.2.2 (ns2) => ns1, reuse port 		[OK]
...
"""

It would read better to have the titles left-justified and the test 
results indented, but that makes all of the test results extra long. Seems 
like you are trying to avoid that (for good reason!).

What do you think about copying the "INFO: ..." style from 
mptcp_connect.sh?

"""
INFO: Init
Created network namespaces ns1, ns2                             [OK]
INFO: Make connections
Established IPv4 MPTCP Connection ns2 => ns1                    [OK]
Established IPv6 MPTCP Connection ns2 => ns1                    [OK]
INFO: Announce tests
ADD_ADDR 10.0.2.2 (ns2) => ns1, invalid token                   [OK]
ADD_ADDR id:55 10.0.2.2 (ns2) => ns1, reuse port                [OK]
...
"""

- Mat


> +}
> +
> kill_wait()
> {
> 	kill $1 > /dev/null 2>&1
> @@ -51,7 +56,7 @@ kill_wait()
>
> cleanup()
> {
> -	echo "cleanup"
> +	print_title "Cleanup"
>
> 	rm -rf $file $client_evts $server_evts
>
> @@ -78,6 +83,8 @@ cleanup()
> 	for netns in "$ns1" "$ns2" ;do
> 		ip netns del "$netns"
> 	done
> +
> +	stdbuf -o0 -e0 printf "Done\n"
> }
>
> trap cleanup EXIT
> @@ -108,6 +115,7 @@ ip -net "$ns2" addr add dead:beef:1::2/64 dev ns2eth1 nodad
> ip -net "$ns2" addr add dead:beef:2::2/64 dev ns2eth1 nodad
> ip -net "$ns2" link set ns2eth1 up
>
> +print_title "Init"
> stdbuf -o0 -e0 printf "Created network namespaces ns1, ns2         \t\t\t[OK]\n"
>
> make_file()
> @@ -255,6 +263,8 @@ verify_announce_event()
>
> test_announce()
> {
> +	print_title "Announce tests"
> +
> 	# Capture events on the network namespace running the server
> 	:>"$server_evts"
>
> @@ -359,6 +369,8 @@ verify_remove_event()
>
> test_remove()
> {
> +	print_title "Remove tests"
> +
> 	# Capture events on the network namespace running the server
> 	:>"$server_evts"
>
> @@ -521,6 +533,8 @@ verify_subflow_events()
>
> test_subflows()
> {
> +	print_title "Subflows v4 or v6 only tests"
> +
> 	# Capture events on the network namespace running the server
> 	:>"$server_evts"
>
> @@ -754,6 +768,8 @@ test_subflows()
>
> test_subflows_v4_v6_mix()
> {
> +	print_title "Subflows v4 and v6 mix tests"
> +
> 	# Attempt to add a listener at 10.0.2.1:<subflow-port>
> 	ip netns exec "$ns1" ./pm_nl_ctl listen 10.0.2.1\
> 	   $app6_port > /dev/null 2>&1 &
> @@ -800,6 +816,8 @@ test_subflows_v4_v6_mix()
>
> test_prio()
> {
> +	print_title "Prio tests"
> +
> 	local count
>
> 	# Send MP_PRIO signal from client to server machine
> @@ -876,6 +894,8 @@ verify_listener_events()
>
> test_listener()
> {
> +	print_title "Listener tests"
> +
> 	# Capture events on the network namespace running the client
> 	:>$client_evts
>
> @@ -902,8 +922,10 @@ test_listener()
> 	verify_listener_events $client_evts $LISTENER_CLOSED $AF_INET 10.0.2.2 $client4_port
> }
>
> +print_title "Make connections"
> make_connection
> make_connection "v6"
> +
> test_announce
> test_remove
> test_subflows
> -- 
> 2.37.2
>
>
>

--
Mat Martineau
Intel
