Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984B4227EAA
	for <mptcp@lists.linux.dev>; Thu,  9 Oct 2025 17:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760032570; cv=none; b=bwTnXUQ1316F8M4c83RNccvveVFXdSAQpIwNOBf0AYjB+vlb92NPKo8ByKufuZ8gPPTfqdA4tpWlrprggUzMFdvmb2+sb1xhoZo2IJ5X7sPsBRyAtvT0Q91V9Lo/VbnNzEqc7fClY1GBa6tTOW0KEHieqTRN5QR2apnZHeT7Gso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760032570; c=relaxed/simple;
	bh=6grW3x7Btc0JJTc3eSwFqS+kJOKW+LXGtQ/7Hfg7hG8=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=RvL3bjcFjFTJTY5BVhaRqJJlmoJiVnBaCUa8aJJlrLEeZHcrneZtkyedv0Gs3hEwPH3mAkrvlCbketSZl57aq46ih1AR+q29HHDmNT6AijwvoRpDaoKo0hYMuHdhHwviE0afdyPAk82Cv22rElIdtnRWdq3p/4jThFIYNq43qvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cA9Dnplk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cA9Dnplk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81392C4CEE7
	for <mptcp@lists.linux.dev>; Thu,  9 Oct 2025 17:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760032570;
	bh=6grW3x7Btc0JJTc3eSwFqS+kJOKW+LXGtQ/7Hfg7hG8=;
	h=Date:From:To:Subject:From;
	b=cA9DnplkvgoyIgMJU37cDaHDk3htR0BjxyOjYYsqwcDfhIT/xm3YqDnS+Fy05xB7l
	 hBeN8Z0rSAQ6EKgTtXED0yfUgMjqQeOA5NZCrudbIoOZ2Dgy0iiaw8ZMi1hzj2HCmJ
	 YC9qmLlAYhi0vjKQ9bEE4mZipbp1yi4ow0F/bM49z8NxVDRVfDKJta5jnHgjUXZKen
	 S8iVi04Q1vjtgb/pl80SEPmc2WkboVUHy3++eXoEtyv06KJFID1JCv2jaJoepmtfYW
	 g89vNOa1THmAGcPqtZWQ5jfdn4ulX7GlwJsK2YtYl+JDc8qyeterliguOjcD5zO+Gb
	 Dg83/e0mH5GZA==
Message-ID: <572123a7-8c0b-4be0-beb6-26c802ae9c5c@kernel.org>
Date: Thu, 9 Oct 2025 19:56:07 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
From: Matthieu Baerts <matttbe@kernel.org>
Content-Language: en-GB, fr-BE
To: MPTCP Linux <mptcp@lists.linux.dev>
Subject: [Weekly meetings] MoM - 10th of September 2025
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Last month, we had our new meeting with Mat (Cruise), and myself (NGI0
Core).


Thanks again for this new good meeting!


Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Krister Johansen, Matthieu Baerts
(NGI0)):

14215589: [net-next,v2,1/4] mptcp: use HMAC-SHA256 library instead of
open-coded HMAC
14215590: [net-next,v2,2/4] selftests: mptcp: add checks for fallback
counters
14215591: [net-next,v2,3/4] net: Add rfs_needed() helper
14215592: [net-next,v2,4/4] mptcp: record subflows in RPS table:
    - Series: mptcp: misc. features for v6.18
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=998152&state=*&archive=both

14221203: [net-next,1/3] mptcp: make ADD_ADDR retransmission timeout
adaptive
14221204: [net-next,2/3] selftests: mptcp: join: tolerate more ADD_ADDR
14221205: [net-next,3/3] selftests: mptcp: join: allow more time to send
ADD_ADDR:
    - Series: mptcp: make ADD_ADDR retransmission timeout adaptive
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=999760&state=*&archive=both

14222571: [net,v2] mptcp: sockopt: make sync_socket_options propagate
SOCK_KEEPOPEN:
    - Submitter: Krister Johansen
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/aL8dYfPZrwedCIh9@templeofstupid.com/

14222812: [net,1/3] netlink: specs: mptcp: fix if-idx attribute type
14222813: [net,2/3] doc: mptcp: net.mptcp.pm_type is deprecated
14222814: [net,3/3] selftests: mptcp: shellcheck: support v0.11.0:
    - Series: mptcp: misc fixes for v6.17-rc6
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=1000198&state=*&archive=both


    our repo (by: Christoph Paasch, Krister Johansen, Matthieu Baerts
(NGI0)):

14204359: [mptcp-next,v2,1/2] net: Add rfs_needed() helper
14204360: [mptcp-next,v2,2/2] mptcp: record subflows in RPS table:
    - Series: mptcp: Support recording MPTCP subflows in RPS table
    - Submitter: Christoph Paasch
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=995486&state=*&archive=both

14210928: [mptcp-net,4/7] netlink: specs: mptcp: fix if-idx attribute type
14210929: [mptcp-net,5/7] doc: mptcp: net.mptcp.pm_type is deprecated
14210930: [mptcp-net,6/7] selftests: mptcp: shellcheck: support v0.11.0

14217919: [mptcp-next,v2,1/3] Squash to "selftests: mptcp: remove
add_addr_timeout settings"
14217920: [mptcp-next,v2,2/3] selftests: mptcp: join: tolerate more ADD_ADDR
14217921: [mptcp-next,v2,3/3] selftests: mptcp: join: allow more time to
send ADD_ADDR:
    - Series: mptcp: fixes for adaptive ADD_ADDR retransmission timeout
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=998827&state=*&archive=both

14220455: mptcp: sockopt: make sync_socket_options propagate SOCK_KEEPOPEN:
    - Series: mptcp: sockopt: make sync_socket_options propagate
SOCK_KEEPOPEN
    - Submitter: Krister Johansen
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=999551&state=*&archive=both

14220727: [mptcp-next] mptcp: remove unused returned value:
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20250906-check_data_fin_ret-v1-1-2c8100bc20eb@kernel.org/



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Matthieu Baerts (NGI0)):

14224583: [net-next] doc: mptcp: fix Netlink specs link:
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20250909-net-next-mptcp-pm-link-v1-1-0f1c4b8439c6@kernel.org/


    our repo (by: Christoph Paasch, Gang Yan, Geliang Tang, Gregory
Detal, Matthieu Baerts, Matthieu Baerts (NGI0)):

12282223: [RESEND,RFC,mptpcp-next] mptcp: add ooo prune support:
13070467: [mptcp-next,v4,1/2] mptcp: update mptcp_push_release
13070468: [mptcp-next,v4,2/2] mptcp: retrans for redundant sends:
    - State: Changes requested
    - Series: BPF redundant scheduler, part 3
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=703615&state=*&archive=both
    - Status: same as last time

13305089: [mptcp-next,1/6] mptcp: sockopt: move tcp_inq code to a
dedicated function
13305091: [mptcp-next,2/6] mptcp: sockopt: update supported list
13305093: [mptcp-next,3/6] mptcp: sockopt: get val in a generic way
13305090: [mptcp-next,4/6] mptcp: sockopt: add missing getsockopt() options
13305094: [mptcp-next,5/6] mptcp: sockopt: set val in a generic way
13305092: [mptcp-next,6/6] mptcp: sockopt: support IP_TTL &
IPV6_UNICAST_HOPS:
    - State: Changes requested
    - Series: mptcp: sockopt: uniform code to get/set values
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=763505&state=*&archive=both
    - Status: same as last time

13583230: [RFC] mptcp: react scheduler when subflow events pop up:
    - State: Changes requested
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/433320c3a9db77bea53a34fc9c43a3c7e3320399.1709693691.git.tanggeliang@kylinos.cn/
    - Status: same as last time

13675217: [mptcp-next,RFC,1/4] mptcp: add push sched callback
13675218: [mptcp-next,RFC,2/4] mptcp: use new push callback to schedule
chunks
13675219: [mptcp-next,RFC,3/4] mptcp: bpf: allow to write to
mptcp_sched_chunk
13675220: [mptcp-next,RFC,4/4] selftests/bpf: mptcp RR: send 1 MSS on
each subflow:
    - State: RFC
    - Series: mptcp: update scheduler API
    - Submitter: Gregory Detal
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=856158&state=*&archive=both
    - Status: same as last time

13932555: [1/3] mptcp: fix invalid addr occupy 'add_addr_accepted'
13932556: [2/3] selftests: mptcp: relax conditions in SYN_TX validation
13932546: [3/3] selftests: mptcp: add a testcase for invalid addr timeout:
    - State: Changes requested
    - Series: [1/3] mptcp: fix invalid addr occupy 'add_addr_accepted'
    - Submitter: Gang Yan
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=923771&state=*&archive=both
    - Status: same as last time

14024767: [mptcp-next,v1,1/4] bpf: Add mptcp path manager struct_ops
14024768: [mptcp-next,v1,2/4] bpf: Export mptcp path manager kfuncs
14024769: [mptcp-next,v1,3/4] selftests/bpf: Add mptcp netlink pm subtest
14024770: [mptcp-next,v1,4/4] selftests/bpf: Add mptcp bpf_netlink pm
subtest:
    - State: Changes requested
    - Series: BPF path manager, part 7
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=946095&state=*&archive=both
    - Status: same as last time

14053397: [mptcp-next,v3,1/3] mptcp: pm: userspace: drop
delete_local_addr helper
14053398: [mptcp-next,v3,2/3] selftests: mptcp: join: update userspace
dump_addr outputs
14053399: [mptcp-next,v3,3/3] selftests: mptcp: userspace: send RM_ADDR
between server and client:
    - State: Under review
    - Series: only remove entry from local_addr_list when sending a
REMOVE_ADDR
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=953862&state=*&archive=both
    - Status: same as last time

14077448: [mptcp-next,v7,1/5] mptcp: pm: call pm worker handler without
pm lock
14077447: [mptcp-next,v7,2/5] mptcp: pm: add accept_new_subflow() interface
14077449: [mptcp-next,v7,3/5] mptcp: pm: add established() interface
14077450: [mptcp-next,v7,4/5] mptcp: pm: add subflow_established() interface
14077451: [mptcp-next,v7,5/5] mptcp: pm: drop is_userspace in
subflow_check_next:
    - State: Needs ack
    - Series: BPF path manager, part 6
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=959912&state=*&archive=both
    - Status: same as last time

14102233: [mptcp-next,v3,1/3] selftests/bpf: Add sndbuf for send_recv_data
14102235: [mptcp-next,v3,2/3] Squash to "selftests/bpf: Add bpf
scheduler test"
14102234: [mptcp-next,v3,3/3] DO-NOT-MERGE: selftests/bpf: Increase
total_bytes of bpf sched tests:
    - State: Changes requested
    - Series: send() fails with EAGAIN in blocking IO mode "487
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=967210&state=*&archive=both
    - Status: same as last time

14167004: [mptcp-next] mptcp: remove redundant orig_offset in
carve_data_frag:
    - State: Changes requested
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/9c663fc37767d9036379afdbc83cd8874a7b2fc9.1753337130.git.tanggeliang@kylinos.cn/
    - Status: same as last time

14175678: [mptcp-next,1/2] mptcp: Add support for SO_MAX_PACING_RATE
14175679: [mptcp-next,2/2] selftests: Add tests for SO_MAX_PACING_RATE:
    - State: Changes requested
    - Series: mptcp: Add support for SO_MAX_PACING_RATE
    - Submitter: Christoph Paasch
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=987909&state=*&archive=both
    - Status: same as last time

14181837: [mptcp-next,v5,1/8] mptcp: handle TCP_MAXSEG getsockopt in
common case
14181838: [mptcp-next,v5,2/8] mptcp: setsockopt support for TCP_MD5SIG
14181839: [mptcp-next,v5,3/8] selftests: mptcp: sockopt: set REUSEADDR
opt helper
14181840: [mptcp-next,v5,4/8] selftests: mptcp: sockopt: add md5 argument
14181841: [mptcp-next,v5,5/8] selftests: mptcp: sockopt: implement
TCP_MD5SIG support
14181842: [mptcp-next,v5,6/8] selftests: mptcp: sockopt: extend MD5
support for TCP_MD5SIG_EXT
14181843: [mptcp-next,v5,7/8] selftests: mptcp: sockopt: handle MD5 in
connection processing
14181844: [mptcp-next,v5,8/8] selftests: mptcp: sockopt: add TCP_MD5SIG
test cases:
    - State: Needs ack
    - Series: mptcp: TCP_MD5SIG support
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=989716&state=*&archive=both
    - Status: same as last time

14185125: [mptcp-next,1/6] mptcp: add helper for setsockopt on first
subflow only
14185126: [mptcp-next,2/6] mptcp: handle SOL_SOCKET options on first
subflow only
14185128: [mptcp-next,3/6] mptcp: refactor IP socket option handling for
first subflow
14185127: [mptcp-next,4/6] mptcp: extract IPv6 socket option handling
for first subflow
14185129: [mptcp-next,5/6] mptcp: handle SOL_TCP options on all subflows
14185130: [mptcp-next,6/6] mptcp: handle IP socket options on all subflows:
    - State: Needs ack
    - Series: refactor MPTCP socket option handling
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=990414&state=*&archive=both
    - Status: same as last time

14185142: [mptcp-next,v2,1/3] mptcp: add IPV6_TCLASS socket option support
14185143: [mptcp-next,v2,2/3] mptcp: add IP_TTL socket option support
14185144: [mptcp-next,v2,3/3] mptcp: add IPV6_UNICAST_HOPS socket option
support:
    - State: Needs ack
    - Series: mptcp: add more sockopts
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=990418&state=*&archive=both
    - Status: same as last time

14197780: [mptcp-next,v2,01/10] selftests: mptcp: sockopt: improve test
output clarity
14197781: [mptcp-next,v2,02/10] selftests: mptcp: sockopt: add
SO_REUSEADDR test helper
14197782: [mptcp-next,v2,03/10] selftests: mptcp: sockopt: add
SO_REUSEPORT test
14197783: [mptcp-next,v2,04/10] selftests: mptcp: sockopt: add
SO_BINDTODEVICE test
14197784: [mptcp-next,v2,05/10] selftests: mptcp: sockopt: add
SO_BINDTOIFINDEX test
14197785: [mptcp-next,v2,06/10] selftests: mptcp: sockopt: add
IP_FREEBIND tests
14197786: [mptcp-next,v2,07/10] selftests: mptcp: sockopt: add
IP_TRANSPARENT tests
14197787: [mptcp-next,v2,08/10] selftests: mptcp: sockopt: add
IP_BIND_ADDRESS_NO_PORT test
14197788: [mptcp-next,v2,09/10] selftests: mptcp: sockopt: add
IP_LOCAL_PORT_RANGE test
14197789: [mptcp-next,v2,10/10] selftests: mptcp: sockopt: add
IPV6_V6ONLY test:
    - State: Changes requested
    - Series: selftests: cover more MPTCP socket options
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=993905&state=*&archive=both
    - Status: same as last time

14204769: [mptcp-next,v3,01/14] selftests: mptcp: sockopt: replace
/dev/urandom with getrandom
14204770: [mptcp-next,v3,02/14] selftests: mptcp: sockopt: add protocol
arguments
14204771: [mptcp-next,v3,03/14] selftests: mptcp: sockopt: add inq argument
14204772: [mptcp-next,v3,04/14] selftests: mptcp: sockopt: set TCP_INQ
on accepted sockets
14204773: [mptcp-next,v3,05/14] selftests: mptcp: sockopt: use unix
socket instead of pipe
14204774: [mptcp-next,v3,06/14] selftests: mptcp: sockopt: read eof at
the end of process_one_client
14204775: [mptcp-next,v3,07/14] selftests: mptcp: sockopt: use recvmsg
instead of read
14204776: [mptcp-next,v3,08/14] selftests: mptcp: sockopt: read one byte
first
14204777: [mptcp-next,v3,09/14] selftests: mptcp: sockopt: add large
data transfer tests
14204778: [mptcp-next,v3,10/14] selftests: mptcp: sockopt: add wait_for_ack
14204779: [mptcp-next,v3,11/14] selftests: mptcp: sockopt: set FIONREAD
ioctl
14204780: [mptcp-next,v3,12/14] selftests: mptcp: sockopt: add
check_tcp_inq helper
14204781: [mptcp-next,v3,13/14] selftests: mptcp: sockopt: replace
mptcp_inq with sockopt
14204782: [mptcp-next,v3,14/14] selftests: mptcp: sockopt: remove
obsolete mptcp_inq:
    - State: Needs ack
    - Series: selftests: consolidate TCP_INQ testing into sockopt
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=995595&state=*&archive=both
    - Status: same as last time

14208094: [mptcp-next,v2,1/3] Add native MPTCP socket creation support
14208095: [mptcp-next,v2,2/3] Add MPTCP support to Java
Socket/ServerSocket APIs
14208096: [mptcp-next,v2,3/3] Add test cases for MPTCP socket functionality:
    - State: Awaiting upstream
    - Series: Add MPTCP support to Java Networking API
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=996382&state=*&archive=both
    - Archived: Geliang is handling that on OpenJDK side

14214090: [mptcp-next,v10,1/9] mptcp: add eat_recv_skb helper
14214091: [mptcp-next,v10,2/9] mptcp: implement .read_sock
14214092: [mptcp-next,v10,3/9] tcp: drop release and lock again in
splice_read
14214093: [mptcp-next,v10,4/9] tcp: export splice_state and splice_data_recv
14214094: [mptcp-next,v10,5/9] tcp: add recv_should_stop helper
14214095: [mptcp-next,v10,6/9] mptcp: use recv_should_stop helper
14214096: [mptcp-next,v10,7/9] mptcp: implement .splice_read
14214097: [mptcp-next,v10,8/9] selftests: mptcp: add splice io mode
14214098: [mptcp-next,v10,9/9] selftests: mptcp: connect: cover splice mode:
    - State: New
    - Series: implement mptcp read_sock
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=997782&state=*&archive=both
    - Will check if Paolo can look at it, or Mat can also look

14215849: [mptcp-net,v2,1/3] selftests: mptcp: close server file descriptor
14215850: [mptcp-net,v2,2/3] selftests: mptcp: close IPC descriptor on
server side
14215851: [mptcp-net,v2,3/3] selftests: mptcp: sockopt: fix error messages:
    - State: New
    - Series: misc fixes for sockopt selftests
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=998230&state=*&archive=both
    - Geliang can send a new version following the modification he
suggested at the end
    - (TODO: Matth: reply to Geliang's last question, just in case he is
not reading ↑ → Done)

14224171: [mptcp-net,v2,1/5] mptcp: pm: netlink: fix if-idx type
14224172: [mptcp-net,v2,2/5] mptcp: set remote_deny_join_id0 on SYN recv
14224173: [mptcp-net,v2,3/5] mptcp: pm: nl: announce deny-join-id0 flag
14224174: [mptcp-net,v2,4/5] selftests: mptcp: userspace pm: validate
deny-join-id0 flag
14224175: [mptcp-net,v2,5/5] mptcp: tfo: record 'deny join id0' info:
    - State: New
    - Series: mptcp: pm: nl: announce deny-join-id0 attribute
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=1000542&state=*&archive=both
    - see modifications on mptcpd side too

14224374: [mptcp-next,1/4] mptcp: pm: netlink: only add server-side attr
when true
14224376: [mptcp-next,2/4] mptcp: pm: netlink: announce server-side flag
14224375: [mptcp-next,3/4] mptcp: pm: netlink: deprecate server-side
attribute
14224377: [mptcp-next,4/4] selftests: mptcp: pm: get server-side flag:
    - State: New
    - Series: mptcp: pm: netlink: announce server-side flag
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=1000598&state=*&archive=both

14225489: [mptcp-net,v3,1/5] mptcp: propagate shutdown to subflows when
possible
14225491: [mptcp-net,v3,2/5] selftests: mptcp: connect: catch IO errors
on listen side
14225490: [mptcp-net,v3,3/5] selftests: mptcp: avoid spurious errors on
TCP disconnect
14225493: [mptcp-net,v3,4/5] selftests: mptcp: print trailing bytes with od
14225492: [mptcp-net,v3,5/5] selftests: mptcp: connect: print pcap suffix:
    - State: Queued
    - Series: selftests: mptcp: avoid spurious errors on TCP disconnect
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=1000860&state=*&archive=both



Issues on GitHub:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 582):

  584  [syzkaller] improve coverage [syzkaller]:
      - Some parts are not covered, and are important: FastOpen,
SynCookies, multiple subflows (?)

  583  KMemLeak: from `mptcp_sk_clone_init()` [bug] [selftests]:
      - not a lot of info, will need to reproduce it first, and
understand if it is a false positive or not

    Recently discussed:

  577  MPTCP fails to establish subflows over more than 2 networks
[question] [feedback-needed]:
      - should we close it next week if no replies?

  532  Userspace PM doesn't have access to `allow_join_id0` /
`allow_join_initial_addr_port` bit from the SYN-ACK [enhancement] [pm]
@matttbe:
      - Matt sent patches

  434  in-kernel PM: increase subflows limit [enhancement] [pm] @matttbe:
      - Matt will look at that


    Bugs (opened, flagged as "bug" and assigned)

  575  sockopt: support `TCP_MD5SIG` and `TCP_MD5SIG_EXT` for
transparent integrations [bug] @geliangtang
  498  in-kernel PM: closed subflows before `RM_ADDR` will not decrement
`add_addr_accepted` [bug] [pm] @geliangtang
  487  `send()` fails with `EAGAIN` in blocking IO mode [bug]
[selftests] [sched] @geliangtang
  484  BPF: `setsockopt` on an MPTCP socket: check support [bug] [bpf]
@geliangtang
  445  MPTCP Info counters: start seq numbers ones from 0 [bug] @geliangtang
  403  userspace pm: only remove entry from `local_addr_list` when
sending a `REMOVE_ADDR` [bug] [pm] @geliangtang
  343  scheduler: react when subflow-level events pop up (ACK/RTO) [bug]
[sched] @geliangtang


    Bugs (opened and flagged as "bug" and not assigned)

  583  KMemLeak: from `mptcp_sk_clone_init()` [bug] [selftests]

  581  Default scheduler under-utilizes newly restored subflows on
long-lived flows after WAN failback; needs penalize/probe/stale
integration (related to #345, #348, #349) [bug] [triage]:
      - TODO: reply

  574  [selftests] `mptcp_connect.sh`: `copyfd_io_poll`: poll timed out
[bug] [selftests]
  572  [syzkaller] WARNING in `skb_try_coalesce` [bug] [syzkaller]
  567  [syzbot] WARNING in `__mark_subflow_endp_available` [bug]
[syzkaller] [reproducer]
  561  [syzkaller]  WARNING in `mptcp_pm_alloc_anno_list` [bug] [syzkaller]
  559  Adapt `mptcp_rcv_space_adjust()` after the recent TCP
modifications (`tcp: receive side improvements`) [bug] [enhancement]
  549  pm: in-kernel: set `msk->pm.work_pending` back to `true` [bug]
[selftests] [pm]
  508  Divide error on device removal [bug] [feedback-needed]
  505  Subflows won't be used when the interface for the main flow is a
subinterface [bug] [feedback-needed]
  495  [syzkaller] KASAN: slab-use-after-free Read in
`__inet6_lookup_established` [bug] [syzkaller]
  494  [syzkaller] WARNING in `__skb_flow_dissect` [bug] [syzkaller]
  492  userspace pm: subflows counter: not updated when a subflows is
removed from the other end [bug]
  491  selftests: `mptcp_join`: tests `Infinite map` & `MP_FAIL MP_RST`
are unstable [bug] [selftests]
  483  [6.1] selftests: `mptcp_connect.sh` failures with
`copyfd_io_poll: poll timed out` errors [bug] [selftests]
  476  packetdrill: coalescing feature doesn't take into account MPTCP
options [bug] [packetdrill]
  475  `simult_flows`: unbalanced bwidth tests are unstable [bug]
[selftests]
  439  mptcp vs net.ipv4.tcp_shrink_window [bug]
  336  Issues with BPF packet scheduler [bug] [sched] [bpf]
  325  selftests: `mptcp_join`: test 18 `signal addresses race test` is
sometimes failing [bug] [selftests]
  324  selftests: `mptcp_join`: tests `fastclose test` & `fastclose
server test` are sometimes failing [bug] [selftests]
  315  Issues with backup flow [bug]


    In Progress (opened, new feature and assigned)

  568  socket option: support `IPV6_TCLASS` [enhancement] @geliangtang
  532  Userspace PM doesn't have access to `allow_join_id0` /
`allow_join_initial_addr_port` bit from the SYN-ACK [enhancement] [pm]
@matttbe
  480  MPTCP and KTLS support [enhancement] @geliangtang
  434  in-kernel PM: increase subflows limit [enhancement] [pm] @matttbe
  353  sockopt: uniform code to get/set values [enhancement] @matttbe
  349  scheduler: (un)mark a subflow as "stale" [enhancement] [sched]
@geliangtang
  296  Support IP_TTL & IPV6_UNICAST_HOPS [enhancement] @matttbe
  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti
   75  BPF: packet scheduler [enhancement] [sched] [bpf] @geliangtang
   74  BPF: path manager [enhancement] [pm] [bpf] @geliangtang


    Assigned Questions (opened, questions and assigned)

  548  disable mptcp for an interface [question] @matttbe


    Open questions (opened, questions and not assigned)

  577  MPTCP fails to establish subflows over more than 2 networks
[question] [feedback-needed]

  562  [performance] How much is the overhead of MPTCP？ [question]
[triage]:
      - TODO: reply

  530  about mptcp subflow creation question [question] [feedback-needed]
  520  Question about proper MPTCP configuration over VPN. [question]
[feedback-needed]
  412  shadowsocks-libev not working, need guidance for PM configuration
[question] [feedback-needed]


    For later (opened and not assigned)

  584  [syzkaller] improve coverage [syzkaller]
  578  sockopt: support `SO_MAX_PACING_RATE` to limit the whole MPTCP
connection [enhancement]
  566  pm: use `signal` + `subflow` + `fullmesh` [enhancement] [pm]
  556  Implement all required bits to C/R MPTCP connections from
user-space (CRIU) [enhancement]
  552  pm: in-kernel: delay before creating new subflows [enhancement]
  545  Deal with multiple pure TCP ACK without MPTCP options [enhancement]
  543  TCPDump: display `MP_TCPRST` info [enhancement]
  542  in-kernel PM: limit to one subflow per network interface for each
connection [enhancement] [pm]
  536  PM: new subflow: avoid selecting initial endpoint upon `ADD_ADDR`
reception if servers deny MPJ to initial address [enhancement] [pm]
  535  TCPDump: display `MP_CAPABLE` C flag [enhancement]
  525  tests: cover more MPTCP socket options [enhancement]
[packetdrill] [selftests]
  521  Implement psock_update_sk_prot, for eBPF SOCKMAP support
[enhancement]
  519  Reset the connection once "MPTCP has been verified" instead of a
fallback [enhancement]
  511  Add MIB counters for sent `MPTCP_RST_EMPTCP` [enhancement]
  503  in-kernel PM: use endpoints only to create subflows with received
`ADD_ADDR` [enhancement] [pm]
  497  in-kernel PM: check to create new subflows when some are
destroyed [enhancement] [pm]
  496  in-kernel PM: store received `ADD_ADDR` [enhancement] [pm]
  481  remove refcount on TCP sockets for the timers [enhancement]
  467  Scheduler: add redundant scheduler support in BPF [enhancement]
[sched]
  462  selftests: print (and set?) random seed [enhancement] [selftests]
  461  Protocol: extend Data-Level Length field [enhancement] [protocol]
  448  Allow sending ADD_ADDR IPv6 with port-number if TCP-timestamps
are enabled [enhancement]
  441  optimize established options generation [enhancement]
  440  in-kernel PM: re-establish subflows after "network" errors
[enhancement] [pm]
  426  selftests: validate listener sockets with multiple accepts
[enhancement] [selftests]
  396  ci: periodically run selftests from the export branch on stable
kernels [enhancement] [selftests]
  389  packetdrill: increase coverage for "early `close()`" cases
[enhancement] [packetdrill]
  350  scheduler: API changes (tasks) [enhancement] [sched]
  348  scheduler: frequently probe "stale" subflow with reinjected data
[enhancement] [sched]
  345  scheduler: "penalise" some subflows by sending less than their
cwnd [enhancement] [sched]
  344  scheduler: new callback to initiate optimisations [enhancement]
[sched]
  337  in-kernel PM: listen socket: support "behind a NAT" use case
[enhancement] [pm]
  335  Server to Client subflows: option to allow joining the initial
address and port [enhancement] [pm]
  334  in-kernel PM: send >1 ADD_ADDR before the establishment of a new
subflow [enhancement] [pm]
  332  scheduler: implement a "opportunistic retransmission"
[enhancement] [sched]
  298  CG Memory accounting for passive MPTCP socket [enhancement]
  289  mptcp: audit comments for non inclusive language [enhancement]
  273  Packetdrill: test outgoing MP_FASTCLOSE [enhancement] [packetdrill]
  266  Packetdrill: add MP_FAIL coverage [packetdrill]
  236  Review supported sockopts list [enhancement]
  234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
[packetdrill]
  222  Netlink event API: add SUBFLOW_CREATED event [enhancement]
  215  TCP Urgent pointer and MPTCP [enhancement]
  213  add MPTCP man page [enhancement]
  208  better handing of ssk memory pressure in the TX path [enhancement]
  202  Add sendmsg support for ancillary data [enhancement]
  197  more mibs needed [enhancement]
  180  Get an update when MPTCP fall back to TCP [enhancement]
  177  improve retransmit subflow selection [enhancement]
  169  packetdrill: add coverage for ADD_ADDR and MP_JOIN on a different
port [enhancement] [packetdrill]
  150  remove completely workqueue usage [enhancement]
  141  avoid acquiring mptcp_data_lock() twice in the receive path
[enhancement]
   78  notify the application (userspace) when a subflow is
added/removed [enhancement]
   41  reduce indirect call usage [enhancement]
   24  Revisit layout of struct mptcp_subflow_context [enhancement]


    Recently closed (since 2025-08-27)

None.


    Packetdrill PRs

  171  4 days ago    matttbe      mptcp: propagate shutdown to subflows
when possible:
      - linked to patches above

  162  2 months ago  geliangtang  mptcp: add splice test
  52   7 months ago  dcaratti     Add initial coverage for RM_ADDR


    mptcp.dev PRs

  67  5 days ago  geliangtang  apps: os: openEuler


    mptcpd PRs

  323  22 hours ago  matttbe  interface: add `deny_join_id0` parameter



FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.18):
https://github.com/orgs/multipath-tcp/projects/16
    - For later: https://github.com/orgs/multipath-tcp/projects/1



Patches to send to NetDev:

    - Fixes for other trees: /

    - Fixes for -net: /

    - Fixes for net-next: /

    - Features for net-next:

        - [fe224fd29054] mptcp: pm: init and release mptcp_pm_ops
(Geliang Tang)
        - [59ba19cd9b5d] mptcp: pm: add get_local_id() interface
(Geliang Tang)
        - [aaecd7a694d8] mptcp: pm: add get_priority() interface
(Geliang Tang):
            - blocked: waiting for PM lock refactoring

        - [e7b8b51e7ab2] mptcp: remove unused returned value of
check_data_fin (Matthieu Baerts (NGI0)):
            - can be sent with others later on

    - Features for net-next (next):


    - Features for other trees:

        - [4f0b48bc9421] bpf: Add mptcp_subflow bpf_iter (Geliang Tang)
        - [067dbd9ee2aa] selftests/bpf: More endpoints for endpoint_init
(Geliang Tang)
        - [ff0f20525359] selftests/bpf: Drop cgroup_fd of run_mptcpify
(Geliang Tang)
        - [0996dea09d51] bpf: Add mptcp packet scheduler struct_ops
(Geliang Tang)
        - [c036396d4eb7] bpf: Export mptcp packet scheduler helpers
(Geliang Tang)
        - [d23a05ca52ee] selftests/bpf: Add bpf scheduler test (Geliang
Tang)
        - [0950079b8fe2] selftests/bpf: Add bpf_first scheduler & test
(Geliang Tang)
        - [f06203af22e4] selftests/bpf: Add bpf_bkup scheduler & test
(Geliang Tang)
        - [d8d3691538fa] selftests/bpf: Add bpf_rr scheduler & test
(Geliang Tang)
        - [e057f15c44b4] selftests/bpf: Add bpf_red scheduler & test
(Geliang Tang)
        - [c44f1198e4d2] selftests/bpf: Add bpf_burst scheduler & test
(Geliang Tang):
            - blocked: waiting for sched API refactoring



Extra tests:
    - news about Syzkaller? (Matth):
        - one issue reported by Syzbot: TODO Matth: check → Done

    - Packetdrill (Davide):
        - /

    - Patchew (Davide):
        - /

    - CI (Matth):
        - https://ci-results.mptcp.dev/flakes.html
        - https://netdev.bots.linux.dev/flakes.html?tn-needle=mptcp
        - Hopefully will be greener soon, thanks to the WIP patches



Next meeting:
    - No meeting on the 24th of September
    - Next one on Wednesday, the 8th of October.
    - 17:30 UTC (8.30am PDT, 5.30pm CEST, 11.30pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20251008



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you soon,
Matt
-- 
Sponsored by the NGI0 Core fund.

