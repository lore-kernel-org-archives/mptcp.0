Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DC7244675
	for <mptcp@lists.linux.dev>; Thu,  9 Oct 2025 17:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760032575; cv=none; b=lDN+YT+nX0J+mQFSFe4AijZz6FaCeEf5rXRXSHl9vL8c8+fD5d8uuGVp0Clco1ygH77zTqQBDrhrOz8NJvhfBxAdQdOcRmZvNeI0KNw/pyJ+ZKxHslwOuqiVV0sgddKiNLjx7WGYuyDpp2pz2q72Y7LTBZjBgJWzr30TWXV5Ihk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760032575; c=relaxed/simple;
	bh=rcGZELekoDjm3q7IFI1oBOzeeO9+HLYLaTG+IGygBg8=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=HnsdZTMuIiP+3nnL96e60yKveNxXzAv1JFkZRdvb2FH5k6yP6f8oEFjDUaLSFHicaiJpjsuLcZ7StBPgVR268g0hskDb03jcxEd+rL8NvP16VsyTqESHYpgJFfy6mgerh+v4SU7jCIxTwq61GqvepovFuarz7Wza22JXm6At92A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VA4budZW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VA4budZW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B7FBC4CEE7
	for <mptcp@lists.linux.dev>; Thu,  9 Oct 2025 17:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760032575;
	bh=rcGZELekoDjm3q7IFI1oBOzeeO9+HLYLaTG+IGygBg8=;
	h=Date:From:To:Subject:From;
	b=VA4budZW/v+eSPdV23oMa8lj6d2Z7Un3DRN2W7aDwy3G6/ygUGjmLagaN+Ct1tszq
	 /ET3MyI6ksmTcJtJ6zb64d1OmU38+/yjtBBCR2xqkryY6Gki90FsHNpJS04jLg0pxJ
	 UxkdHONXzCvByvcqS71QxzLtZ42JERembGSMZybm5S+e7/slDcGuLpFjGkZGuAkCfL
	 eZvurgyvmy8ibU6IEMijdjZQBkMMq8HaYnsMOoYxmZODyr89Jp7NR5IjlFlnr/yVWF
	 3EaSeLG5h4S6tz9WoAIomzqrQQEp3FK6Y0pJ+10ZglIZnTgDX3EOUD2y+1zRjkKv0b
	 77CGjbYXYIi4w==
Message-ID: <35cdc304-99f8-4831-89d3-1b871c526ab2@kernel.org>
Date: Thu, 9 Oct 2025 19:56:13 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
From: Matthieu Baerts <matttbe@kernel.org>
Content-Language: en-GB, fr-BE
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
To: MPTCP Linux <mptcp@lists.linux.dev>
Subject: [Weekly meetings] MoM - 8th of October 2025
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Yesterday, we had our new meeting with Mat (Cruise), and myself (NGI0 Core).


Thanks again for this new good meeting!


Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3

    netdev (if mptcp ML is in cc) (by: Kenta Akagi, Matthieu Baerts (NGI0)):

14224583: [net-next] doc: mptcp: fix Netlink specs link:
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20250909-net-next-mptcp-pm-link-v1-1-0f1c4b8439c6@kernel.org/

14228972: [net,1/5] mptcp: propagate shutdown to subflows when possible
14228973: [net,2/5] selftests: mptcp: connect: catch IO errors on listen
side
14228974: [net,3/5] selftests: mptcp: avoid spurious errors on TCP
disconnect
14228975: [net,4/5] selftests: mptcp: print trailing bytes with od
14228976: [net,5/5] selftests: mptcp: connect: print pcap prefix:
    - Series: selftests: mptcp: avoid spurious errors on TCP disconnect
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=1001767&state=*&archive=both

14229022: [net,1/5] mptcp: set remote_deny_join_id0 on SYN recv
14229023: [net,2/5] mptcp: pm: nl: announce deny-join-id0 flag
14229024: [net,3/5] selftests: mptcp: userspace pm: validate
deny-join-id0 flag
14229025: [net,4/5] mptcp: tfo: record 'deny join id0' info
14229026: [net,5/5] selftests: mptcp: sockopt: fix error messages:
    - Series: mptcp: pm: nl: announce deny-join-id0 flag
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=1001782&state=*&archive=both

14229368: [net-next,1/3] selftests: mptcp: close server file descriptors
14229369: [net-next,2/3] selftests: mptcp: close server IPC descriptors
14229370: [net-next,3/3] mptcp: pm: netlink: fix if-idx type:
    - Series: mptcp: misc minor cleanups
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=1001891&state=*&archive=both

14233178: [iproute] mptcp: fix event attributes type:
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20250916-mptcp-attr-sign-v1-1-316aa96b93ca@kernel.org/

14236715: [net-next] mptcp: reset blackhole on success with non-loopback
ifaces:
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20250918-net-next-mptcp-blackhole-reset-loopback-v1-1-bf5818326639@kernel.org/

14238933: [net-next,1/6] mptcp: pm: netlink: only add server-side attr
when true
14238934: [net-next,2/6] mptcp: pm: netlink: announce server-side flag
14238935: [net-next,3/6] mptcp: pm: netlink: deprecate server-side attribute
14238936: [net-next,4/6] selftests: mptcp: pm: get server-side flag
14238937: [net-next,5/6] mptcp: use _BITUL() instead of (1 << x)
14238938: [net-next,6/6] mptcp: remove unused returned value of
check_data_fin:
    - Series: mptcp: pm: netlink: announce server-side flag
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=1004239&state=*&archive=both

14239583: [6.16.y] mptcp: pm: nl: announce deny-join-id0 flag:
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20250919214921.3467324-2-matttbe@kernel.org/

14239585: [6.12.y] mptcp: pm: nl: announce deny-join-id0 flag:
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20250919215222.3519719-2-matttbe@kernel.org/

14239650: [6.6.y,1/2] mptcp: pm: nl: announce deny-join-id0 flag
14239651: [6.6.y,2/2] selftests: mptcp: userspace pm: validate
deny-join-id0 flag:
    - Series: mptcp: fix recent failed backports (20250919)
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=1004427&state=*&archive=both

14239659: [6.1.y,1/2] mptcp: pm: nl: announce deny-join-id0 flag
14239660: [6.1.y,2/2] selftests: mptcp: userspace pm: validate
deny-join-id0 flag:
    - Series: mptcp: fix recent failed backports (20250919)
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=1004429&state=*&archive=both

14239672: [5.15.y] mptcp: set remote_deny_join_id0 on SYN recv:
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20250919231743.3957803-2-matttbe@kernel.org/

14245934: [net-next,01/15] mptcp: pm: in-kernel: usable client side with
C-flag
14245935: [net-next,02/15] selftests: mptcp: join: validate C-flag + def
limit
14245936: [net-next,03/15] mptcp: pm: in-kernel: refactor
fill_local_addresses_vec
14245937: [net-next,04/15] mptcp: pm: in-kernel: refactor
fill_remote_addresses_vec
14245938: [net-next,05/15] mptcp: pm: rename 'subflows' to 'extra_subflows'
14245939: [net-next,06/15] mptcp: pm: in-kernel: rename 'subflows_max'
to 'limit_extra_subflows'
14245940: [net-next,07/15] mptcp: pm: in-kernel: rename
'add_addr_signal_max' to 'endp_signal_max'
14245941: [net-next,08/15] mptcp: pm: in-kernel: rename
'add_addr_accept_max' to 'limit_add_addr_accepted'
14245942: [net-next,09/15] mptcp: pm: in-kernel: rename 'local_addr_max'
to 'endp_subflow_max'
14245943: [net-next,10/15] mptcp: pm: in-kernel: rename
'local_addr_list' to 'endp_list'
14245944: [net-next,11/15] mptcp: pm: in-kernel: rename 'addrs' to
'endpoints'
14245945: [net-next,12/15] mptcp: pm: in-kernel: remove stale_loss_cnt
14245946: [net-next,13/15] mptcp: pm: in-kernel: reduce pernet struct size
14245947: [net-next,14/15] mptcp: pm: in-kernel: compare IDs instead of
addresses
14245948: [net-next,15/15] mptcp: pm: in-kernel: add laminar endpoints:
    - Series: mptcp: pm: special case for c-flag + luminar endp
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=1006117&state=*&archive=both

14248454: [net-next,1/8] mptcp: leverage skb deferral free
14248455: [net-next,2/8] tcp: make tcp_rcvbuf_grow() accessible to mptcp
code
14248456: [net-next,3/8] mptcp: rcvbuf auto-tuning improvement
14248457: [net-next,4/8] mptcp: introduce the mptcp_init_skb helper
14248458: [net-next,5/8] mptcp: remove unneeded mptcp_move_skb()
14248459: [net-next,6/8] mptcp: factor out a basic skb coalesce helper
14248460: [net-next,7/8] mptcp: minor move_skbs_to_msk() cleanup
14248461: [net-next,8/8] selftests: mptcp: join: validate new laminar endp:
    - Series: mptcp: receive path improvement
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=1006748&state=*&archive=both

14253556: [6.1.y] selftests: mptcp: connect: fix build regression caused
by backport:
    - Submitter: Kenta Akagi
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20251002141759.76891-1-k@mgml.me/

14255173: [net,repost] selftests: net: sort configs:
    - State: New
    - Submitter: Jakub Kicinski
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20251003205736.1019673-1-kuba@kernel.org/

14255177: [net,v2] selftests: net: unify the Makefile formats:
    - State: New
    - Submitter: Jakub Kicinski
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20251003210127.1021918-1-kuba@kernel.org/


    our repo (by: Geliang Tang, Matthieu Baerts (NGI0), Paolo Abeni):

14224171: [mptcp-net,v2,1/5] mptcp: pm: netlink: fix if-idx type
14224172: [mptcp-net,v2,2/5] mptcp: set remote_deny_join_id0 on SYN recv
14224173: [mptcp-net,v2,3/5] mptcp: pm: nl: announce deny-join-id0 flag
14224174: [mptcp-net,v2,4/5] selftests: mptcp: userspace pm: validate
deny-join-id0 flag
14224175: [mptcp-net,v2,5/5] mptcp: tfo: record 'deny join id0' info:
    - Series: mptcp: pm: nl: announce deny-join-id0 attribute
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=1000542&state=*&archive=both

14224374: [mptcp-next,1/4] mptcp: pm: netlink: only add server-side attr
when true
14224376: [mptcp-next,2/4] mptcp: pm: netlink: announce server-side flag
14224375: [mptcp-next,3/4] mptcp: pm: netlink: deprecate server-side
attribute
14224377: [mptcp-next,4/4] selftests: mptcp: pm: get server-side flag:
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
    - Series: selftests: mptcp: avoid spurious errors on TCP disconnect
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=1000860&state=*&archive=both

14228114: [mptcp-net,v3,1/3] selftests: mptcp: sockopt: fix error messages
14228115: [mptcp-next,v3,2/3] selftests: mptcp: close server file
descriptors
14228116: [mptcp-next,v3,3/3] selftests: mptcp: close server IPC
descriptors:
    - Series: misc fixes for sockopt selftests
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=1001578&state=*&archive=both

14229001: [mptcp-next] Squash to "selftests: mptcp: userspace pm:
validate deny-join-id0 flag":
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20250912123811.1179276-2-matttbe@kernel.org/

14233169: [mptcp-next] mptcp: use _BITUL() instead of (1 << x):
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20250916-mptcp-pm-addr-flag-bitul-v1-1-5805a6ddde27@kernel.org/

14233271: [mptcp-net,v2,1/2] mptcp: pm: in-kernel: usable client side
with C-flag
14233272: [mptcp-net,v2,2/2] selftests: mptcp: join: validate C-flag +
def limit:
    - Series: mptcp: pm: in-kernel: usable client side with C-flag
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=1002880&state=*&archive=both

14238436: [mptcp-next,v2,01/10] Squash to "mptcp: pm: in-kernel: usable
client side with C-flag"
14238437: [mptcp-next,v2,02/10] mptcp: pm: in-kernel: refactor
fill_local_addresses_vec
14238438: [mptcp-next,v2,03/10] mptcp: pm: in-kernel: refactor
fill_remote_addresses_vec
14238439: [mptcp-next,v2,04/10] mptcp: pm: rename 'subflows' to
'extra_subflows'
14238440: [mptcp-next,v2,05/10] mptcp: pm: in-kernel: rename
'subflows_max' to 'limit_extra_subflows'
14238441: [mptcp-next,v2,06/10] mptcp: pm: in-kernel: rename
'add_addr_signal_max' to 'endp_signal_max'
14238442: [mptcp-next,v2,07/10] mptcp: pm: in-kernel: rename
'add_addr_accept_max' to 'limit_add_addr_accepted'
14238443: [mptcp-next,v2,08/10] mptcp: pm: in-kernel: rename
'local_addr_max' to 'endp_subflow_max'
14238444: [mptcp-next,v2,09/10] mptcp: pm: in-kernel: rename
'local_addr_list' to 'endp_list'
14238445: [mptcp-next,v2,10/10] mptcp: pm: in-kernel: rename 'addrs' to
'endpoints':
    - Series: mptcp: pm: a few cleanups
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=1004147&state=*&archive=both

14239307: [next,v3,01/12] mptcp: leverage skb deferral free
14239308: [next,v3,02/12] tcp: make tcp_rcvbuf_grow() accessible to
mptcp code
14239309: [next,v3,03/12] mptcp: rcvbuf auto-tuning improvement
14239313: [next,v3,04/12] mptcp: introduce the mptcp_init_skb helper.
14239310: [next,v3,05/12] mptcp: remove unneeded mptcp_move_skb()
14239311: [next,v3,06/12] mptcp: factor out a basic skb coalesce helper
14239312: [next,v3,07/12] mptcp: minor move_skbs_to_msk() cleanup
14239770: [mptcp-next,1/2] Squash to "mptcp: factor out a basic skb
coalesce helper"
14245720: [mptcp-next,v3,1/6] mptcp: pm: in-kernel: remove stale_loss_cnt
14245721: [mptcp-next,v3,2/6] mptcp: pm: in-kernel: reduce pernet struct
size
14245722: [mptcp-next,v3,3/6] mptcp: pm: in-kernel: compare IDs instead
of addresses
14245723: [mptcp-next,v3,4/6] Squash to "mptcp: pm: in-kernel: usable
client side with C-flag"
14245724: [mptcp-next,v3,5/6] mptcp: pm: in-kernel: add laminar endpoints
14245725: [mptcp-next,v3,6/6] selftests: mptcp: join: validate new
laminar endp:
    - Series: mptcp: pm: in-kernel: add 'address' endpoints
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=1006064&state=*&archive=both



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Jakub Kicinski, Mehdi Ben Hadj
Khelifa):

14245817: [v3,1/3] selftests/bpf: Prepare to add -Wsign-compare for bpf
tests
14245818: [v3,2/3] selftests/bpf: Prepare to add -Wsign-compare for bpf
tests
14245819: [v3,3/3] selftests/bpf: Prepare to add -Wsign-compare for bpf
tests:
    - Series: selftests/bpf: Prepare to add -Wsign-compare for bpf selftests
    - Submitter: Mehdi Ben Hadj Khelifa
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=1006094&state=*&archive=both


    our repo (by: Christoph Paasch, Gang Yan, Geliang Tang, Gregory
Detal, Matthieu Baerts, Matthieu Baerts (NGI0), Paolo Abeni):

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

14215849: [mptcp-net,v2,1/3] selftests: mptcp: close server file descriptor
14215850: [mptcp-net,v2,2/3] selftests: mptcp: close IPC descriptor on
server side
14229120: [mptcp-next,v4,1/9] selftests: mptcp: sockopt: replace
/dev/urandom with getrandom
14229121: [mptcp-next,v4,2/9] selftests: mptcp: sockopt: add protocol
arguments
14229122: [mptcp-next,v4,3/9] selftests: mptcp: sockopt: add inq argument
14229123: [mptcp-next,v4,4/9] selftests: mptcp: sockopt: rename pipefd
to ipcfd
14229124: [mptcp-next,v4,5/9] selftests: mptcp: sockopt: set TCP_INQ sockopt
14229125: [mptcp-next,v4,6/9] selftests: mptcp: sockopt: handle INQ on
server side
14229126: [mptcp-next,v4,7/9] selftests: mptcp: sockopt: handle INQ on
client side
14229127: [mptcp-next,v4,8/9] selftests: mptcp: sockopt: replace
mptcp_inq with sockopt
14229128: [mptcp-next,v4,9/9] selftests: mptcp: sockopt: remove obsolete
mptcp_inq:
    - State: New
    - Series: selftests: consolidate TCP_INQ testing into sockopt
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=1001827&state=*&archive=both
    - Status: same as last time

14242076: [mptcp-next] selftests: mptcp: pm: fix pm_nl_ctl build errors
with old glibc:
    - State: New
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/092fc76415deb1b45da5bb691ef6069fbab7dd09.1758591744.git.tanggeliang@kylinos.cn/
    - TODO: Matth: ask Geliang if pm_nl_ctl is still needed for the BPF
CI → Done

14248479: [mptcp-next,v12,1/8] mptcp: add eat_recv_skb helper
14248480: [mptcp-next,v12,2/8] mptcp: implement .read_sock
14248481: [mptcp-next,v12,3/8] tcp: export splice_state and splice_data_recv
14248482: [mptcp-next,v12,4/8] tcp: add recv_should_stop helper
14248483: [mptcp-next,v12,5/8] mptcp: use recv_should_stop helper
14248484: [mptcp-next,v12,6/8] mptcp: implement .splice_read
14248485: [mptcp-next,v12,7/8] selftests: mptcp: add splice io mode
14248486: [mptcp-next,v12,8/8] selftests: mptcp: connect: cover splice mode:
    - State: New
    - Series: implement mptcp read_sock
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=1006759&state=*&archive=both
    - Mat will look at it

14255898: [v5,mptcp-next,01/10] mptcp: borrow forward memory from subflow
14255899: [v5,mptcp-next,02/10] mptcp: cleanup fallback data fin reception
14255900: [v5,mptcp-next,03/10] mptcp: cleanup fallback dummy mapping
generation
14255901: [v5,mptcp-next,04/10] mptcp: fix MSG_PEEK stream corruption
14255902: [v5,mptcp-next,05/10] mptcp: ensure the kernel PM does not
take action too late
14255904: [v5,mptcp-next,06/10] mptcp: do not miss early first subflow
close event notification.
14255903: [v5,mptcp-next,07/10] mptcp: make mptcp_destroy_common() static
14255905: [v5,mptcp-next,08/10] mptcp: drop the __mptcp_data_ready() helper
14255906: [v5,mptcp-next,09/10] mptcp: introduce mptcp-level backlog
14255907: [v5,mptcp-next,10/10] mptcp: leverage the backlog for RX
packet processing:
    - State: Under review
    - Series: mptcp: introduce backlog processing
    - Submitter: Paolo Abeni
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=1008615&state=*&archive=both
    - TODO: Probably better to have a few more eyes on this series,
especially on the last two patches.

14258320: [mptcp-net,1/7] mptcp: pm: in-kernel: C-flag: handle late ADD_ADDR
14258321: [mptcp-net,2/7] selftests: mptcp: join: mark 'flush re-add' as
skipped if not supported
14258322: [mptcp-net,3/7] selftests: mptcp: join: mark 'delete re-add
signal' as skipped if not supported
14258323: [mptcp-net,4/7] selftests: mptcp: join: mark implicit tests as
skipped if not supported
14258324: [mptcp-net,5/7] selftests: mptcp: join: mark laminar tests as
skipped if not supported
14258325: [mptcp-net,6/7] mptcp: pm: in-kernel: record fullmesh endp nb
14258326: [mptcp-net,7/7] mptcp: pm: in kernel: only use fullmesh endp
if any:
    - State: New
    - Series: mptcp: pm: in-kernel: C-flag: handle late ADD_ADDR + misc.
    - Submitter: Matthieu Baerts (NGI0)
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=1009412&state=*&archive=both



Issues on GitHub:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 584):

  590  in-kernel PM: use either `subflow` or `signal` depending on
connector/listener app [enhancement]:
      - it might help to setup endpoints with both flags, and this new
option

  589  selftests: `simult_flows`: "unbalanced bwidth with opposed,
unbalanced delay" is unstable [bug] [selftests]:
      - it looks like it is linked to "mptcp: receive path improvement"
      - many tests on NIPA are failing now
      -
https://netdev.bots.linux.dev/flakes.html?tn-needle=mptcp&br-pfx=net-next
      - Needs to be investigated

  588  in-kernel PM: support NUMA awareness [enhancement]:
      - maybe not needed netns can be used?
      - or a global option
      - (or userspace/BPF PM)

  587  in-kernel PM: Server is only using single IP to establish
subflows [bug]:
      - "laminar" flag is helpful
      - but still a different issue with bind

  586  [syzkaller] WARNING in `subflow_data_ready` [bug] [syzkaller]:
      - To be checked

  585  MPTCP stalls when primary path connectivity is lost but interface
remains up [bug]:
      - TODO: Matth: check the reply


    Recently discussed:

  584  [syzkaller] improve coverage [syzkaller]:
      - Geliang might look at that (assign him?)

  583  KMemLeak: from `mptcp_sk_clone_init()` [bug] [selftests]:
      - To be checked!

  574  [selftests] `mptcp_connect.sh`: `copyfd_io_poll`: poll timed out
[bug] [selftests]:
      - To be checked


    Bugs (opened, flagged as "bug" and assigned)

  575  sockopt: support `TCP_MD5SIG` and `TCP_MD5SIG_EXT` for
transparent integrations [bug] @geliangtang
  498  in-kernel PM: closed subflows before `RM_ADDR` will not decrement
`add_addr_accepted` [bug] [pm] @geliangtang
  484  BPF: `setsockopt` on an MPTCP socket: check support [bug] [bpf]
@geliangtang
  445  MPTCP Info counters: start seq numbers ones from 0 [bug] @geliangtang
  403  userspace pm: only remove entry from `local_addr_list` when
sending a `REMOVE_ADDR` [bug] [pm] @geliangtang
  343  scheduler: react when subflow-level events pop up (ACK/RTO) [bug]
[sched] @geliangtang


    Bugs (opened and flagged as "bug" and not assigned)

  589  selftests: `simult_flows`: "unbalanced bwidth with opposed,
unbalanced delay" is unstable [bug] [selftests]
  587  in-kernel PM: Server is only using single IP to establish
subflows [bug]
  586  [syzkaller] WARNING in `subflow_data_ready` [bug] [syzkaller]
  585  MPTCP stalls when primary path connectivity is lost but interface
remains up [bug]
  583  KMemLeak: from `mptcp_sk_clone_init()` [bug] [selftests]
  581  Default scheduler under-utilizes newly restored subflows on
long-lived flows after WAN failback; needs penalize/probe/stale
integration (related to #345, #348, #349) [bug] [triage]
  574  [selftests] `mptcp_connect.sh`: `copyfd_io_poll`: poll timed out
[bug] [selftests]
  572  [syzkaller] WARNING in `skb_try_coalesce` [bug] [syzkaller]
  567  [syzbot] WARNING in `__mark_subflow_endp_available` [bug]
[syzkaller] [reproducer]
  561  [syzkaller]  WARNING in `mptcp_pm_alloc_anno_list` [bug] [syzkaller]
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

  562  [performance] How much is the overhead of MPTCP？ [question] [triage]
  530  about mptcp subflow creation question [question] [feedback-needed]
  520  Question about proper MPTCP configuration over VPN. [question]
[feedback-needed]
  412  shadowsocks-libev not working, need guidance for PM configuration
[question] [feedback-needed]

    For later (opened and not assigned)

  590  in-kernel PM: use either `subflow` or `signal` depending on
connector/listener app [enhancement]
  588  in-kernel PM: support NUMA awareness [enhancement]
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
  535  TCPDump: display `MP_CAPABLE` C flag [enhancement]
  525  tests: cover more MPTCP socket options [enhancement]
[packetdrill] [selftests]
  521  Implement psock_update_sk_prot, for eBPF SOCKMAP support
[enhancement]
  519  Reset the connection once "MPTCP has been verified" instead of a
fallback [enhancement]
  511  Add MIB counters for sent `MPTCP_RST_EMPTCP` [enhancement]
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


    Recently closed (since 20250910)

  577  MPTCP fails to establish subflows over more than 2 networks
[question] [feedback-needed]
  559  Adapt `mptcp_rcv_space_adjust()` after the recent TCP
modifications (`tcp: receive side improvements`) [bug] [enhancement]
  536  PM: new subflow: avoid selecting initial endpoint upon `ADD_ADDR`
reception if servers deny MPJ to initial address [enhancement] [pm] @matttbe
  532  Userspace PM doesn't have access to `allow_join_id0` /
`allow_join_initial_addr_port` bit from the SYN-ACK [enhancement] [pm]
@matttbe
  503  in-kernel PM: use endpoints only to create subflows with received
`ADD_ADDR` (`laminar` flag) [enhancement] [pm] @matttbe
  487  `send()` fails with `EAGAIN` in blocking IO mode [bug]
[selftests] [sched] @geliangtang


    Packetdrill PRs

  162  3 months ago  geliangtang  mptcp: add splice test
  52   8 months ago  dcaratti     Add initial coverage for RM_ADDR


    mptcp.dev PRs: /


    mptcpd PRs

  323  28 days ago  matttbe  interface: add `deny_join_id0` parameter:
      - To be reviewed
      - TODO: Matth: add one for "luminar" → done



FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.18):
https://github.com/orgs/multipath-tcp/projects/16
    - For later: https://github.com/orgs/multipath-tcp/projects/1
    - TODO: Matth: update changelog + new project → Done



Patches to send to NetDev:

    - Fixes for other trees:

        - [755e40f85002] selftests/bpf: Fix open-coded gettid syscall in
uprobe syscall tests (Jiri Olsa)
        - [179b2cedb6a2] selftests/bpf: Fix typo in subtest_basic_usdt
after merge conflict (Jiri Olsa)
        - [1830778292dd] selftests/bpf: Fix realloc size in
bpf_get_addrs (Jiri Olsa):
            - should be now in Linus tree

        - [e3ddca210ec2] selftests: bpf: fix recent compilation errors
(Matthieu Baerts (NGI0)):
            - workaround: a new version of pahole is needed to avoid
these errors

    - Fixes for -net: /

    - Fixes for net-next: /

    - Features for net-next:

        - [be533523193c] mptcp: pm: init and release mptcp_pm_ops
(Geliang Tang)
        - [7eed553ed1d7] mptcp: pm: add get_local_id() interface
(Geliang Tang)
        - [217dccdf53f8] mptcp: pm: add get_priority() interface
(Geliang Tang):
            - net-next is closed

    - Features for net-next (next): /

    - Features for other trees:

        - [aec92428a01d] bpf: Add mptcp_subflow bpf_iter (Geliang Tang)
        - [de14001bb9c2] selftests/bpf: More endpoints for endpoint_init
(Geliang Tang)
        - [4c21f4c4e190] selftests/bpf: Drop cgroup_fd of run_mptcpify
(Geliang Tang)
        - [34841f83ec98] bpf: Add mptcp packet scheduler struct_ops
(Geliang Tang)
        - [c0cac57aca50] bpf: Export mptcp packet scheduler helpers
(Geliang Tang)
        - [0f1bf308f5c5] selftests/bpf: Add bpf scheduler test (Geliang
Tang)
        - [d8b41ddced2c] selftests/bpf: Add bpf_first scheduler & test
(Geliang Tang)
        - [3f6a8ef4ee7c] selftests/bpf: Add bpf_bkup scheduler & test
(Geliang Tang)
        - [f0676b785c34] selftests/bpf: Add bpf_rr scheduler & test
(Geliang Tang)
        - [a6a9abddb154] selftests/bpf: Add bpf_red scheduler & test
(Geliang Tang)
        - [9b01f60b230b] selftests/bpf: Add bpf_burst scheduler & test
(Geliang Tang):
            - blocked: waiting for new sched refactor



Extra tests:
    - news about Syzkaller? (Matth):
        - TODO: Matth: recheck

    - Packetdrill (Davide):
        - /

    - Patchew (Davide):
        - /

    - CI (Matth):
        - https://ci-results.mptcp.dev/flakes.html
        - https://netdev.bots.linux.dev/flakes.html?tn-needle=mptcp
        - issues with simult_flows
        - improvement: now the "normal" and "debug" jobs are split in
two: with and without mptcp_join.sh → faster, not to time the 2h timeout



Next meeting:
    - Next one on Wednesday, the 22nd of October.
    - 17:30 UTC (8.30am PDT, 5.30pm CEST, 11.30pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20251022



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you soon,
Matt
-- 
Sponsored by the NGI0 Core fund.

