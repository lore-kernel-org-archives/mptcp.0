Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A12E188A2E
	for <mptcp@lists.linux.dev>; Fri, 27 Sep 2024 07:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727423994; cv=none; b=O0epzTIUHN5X2rFq2ydSE77U5QxRLRs7OMFr/PNXgXR+4299ZmIoHgEeG4sBlRZuhXKf54j7Ue/imxMJHYtyI3DBO1WMBIgk4MPty3I/h/5d9pxYfenP25jQO+PrS3GgfHY9YBxgVRv+IExRgRUEC9CI6cYq4TgCx2DI5P1uRAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727423994; c=relaxed/simple;
	bh=2rX75+goPijgvD/UkJ5/dqul6jUl7LK4lWreZuXKA70=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=orU/y2eFKvmgMkqM8cwM3IfnroOGuLIDdk+x/EVWZsEepRMpWALMW4ki3HpB1n9g/GiS6QNi3IZzebNh/k6W0B4nLRC852fwPgzbsDNb1AZYeeRm8hKD6uu5SUiK+8sAT2Q5f4ULBX1WShwx4gt1DDAuVQ28s9YxUonlsciXGog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNf21mVD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNf21mVD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C01BC4CEC4
	for <mptcp@lists.linux.dev>; Fri, 27 Sep 2024 07:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727423993;
	bh=2rX75+goPijgvD/UkJ5/dqul6jUl7LK4lWreZuXKA70=;
	h=Date:From:Subject:To:From;
	b=SNf21mVDxRrwa/FJCFF2FSi/P1izGAdKPrdk7Dgi0ENeXcwG9KueWAEqq0+SCm0Xx
	 XQZOhYNfwhTFmnqCwlnITqi+5oyOkQ+NWf8qb+1I49VnvCZzqJj+5qCUv6fuSjRoHP
	 NuoeUMtL918mMwgAM1BBOE1Cj0NhgAihp8xsSBx63IrNlYpzY8ZvPRaJv/PtmhsLwU
	 plaAK5/MHwElwYkQ3GLX3hoY6cAzBcce0nsTR31Qt5VjS7Gv+NOQ4fUvO2i7xZ7Vhb
	 WLJmXbqrr1rrJnQEfZ7x03mpEv/hiWoPmoGPRYd4l+mIkV1rglb9eq61WVe49xc36h
	 5L6wJMpVMAD8w==
Message-ID: <dd949625-70db-4e9d-a805-67a835638553@kernel.org>
Date: Fri, 27 Sep 2024 09:59:50 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Content-Language: en-GB
From: Matthieu Baerts <matttbe@kernel.org>
Subject: [Weekly meetings] MoM - 27th of September 2024
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
To: MPTCP Linux <mptcp@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

This week, we had our new meeting with Christoph (Apple), and myself
(NGI0 Core).


Thanks again for this new good meeting!

Here are the minutes of the meeting:



Accepted patches:
    - The list of accepted patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=3


    netdev (if mptcp ML is in cc) (by: Asbjørn Sloth Tønnesen, Edward
Adam Davis, Matthieu Baerts):

13780721: [net,v2,01/15] mptcp: pm: reuse ID 0 after delete and re-add
13780722: [net,v2,02/15] mptcp: pm: fix RM_ADDR ID for the initial subflow
13780723: [net,v2,03/15] selftests: mptcp: join: check removing ID 0
endpoint
13780724: [net,v2,04/15] mptcp: pm: send ACK on an active subflow
13780725: [net,v2,05/15] mptcp: pm: skip connecting to already
established sf
13780726: [net,v2,06/15] mptcp: pm: reset MPC endp ID when re-added
13780727: [net,v2,07/15] selftests: mptcp: join: check re-adding init
endp with != id
13780728: [net,v2,08/15] selftests: mptcp: join: no extra msg if no counter
13780729: [net,v2,09/15] mptcp: pm: do not remove already closed subflows
13780730: [net,v2,10/15] mptcp: pm: fix ID 0 endp usage after multiple
re-creations
13780731: [net,v2,11/15] selftests: mptcp: join: check re-re-adding ID 0
endp
13780732: [net,v2,12/15] mptcp: avoid duplicated SUB_CLOSED events
13780733: [net,v2,13/15] selftests: mptcp: join: validate event numbers
13780734: [net,v2,14/15] mptcp: pm: ADD_ADDR 0 is not a new address
13780735: [net,v2,15/15] selftests: mptcp: join: check re-re-adding ID 0
signal:
    - Series: mptcp: more fixes for the in-kernel PM
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=884100&state=*&archive=both

13787040: [net-next,01/11] mptcp: pm: rename helpers linked to 'flush'
13787041: [net-next,02/11] mptcp: pm: reduce entries iterations on connect
13787042: [net-next,03/11] mptcp: MIB counters for sent MP_JOIN
13787043: [net-next,04/11] selftests: mptcp: join: reduce join_nr params
13787044: [net-next,05/11] selftests: mptcp: join: one line for join check
13787045: [net-next,06/11] selftests: mptcp: join: validate MPJ SYN TX
MIB counters
13787046: [net-next,07/11] selftests: mptcp: join: more explicit check name
13787047: [net-next,08/11] selftests: mptcp: join: specify host being
checked
13787048: [net-next,09/11] selftests: mptcp: join: mute errors when ran
in the background
13787049: [net-next,10/11] selftests: mptcp: join: simplify checksum_tests
13787050: [net-next,11/11] selftests: mptcp: pm_nl_ctl: remove
re-definition:
    - Series: mptcp: MIB counters for MPJ TX + misc improvements
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=885806&state=*&archive=both

13787554: [6.10.y,1/6] selftests: mptcp: add explicit test case for
remove/readd
13787555: [6.10.y,2/6] selftests: mptcp: join: test for flush/re-add
endpoints
13787556: [6.10.y,3/6] selftests: mptcp: join: check re-using ID of
unused ADD_ADDR
13787557: [6.10.y,4/6] selftests: mptcp: join: check re-adding init endp
with != id
13787558: [6.10.y,5/6] selftests: mptcp: join: validate event numbers
13787559: [6.10.y,6/6] selftests: mptcp: join: check re-re-adding ID 0
signal:
    - Series: Backport of "selftests: mptcp: join: test for flush/re-add
endpoints" and more
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=885968&state=*&archive=both

13788446: [6.6.y,1/4] selftests: mptcp: add explicit test case for
remove/readd
13788447: [6.6.y,2/4] selftests: mptcp: join: test for flush/re-add
endpoints
13788448: [6.6.y,3/4] selftests: mptcp: join: check re-using ID of
unused ADD_ADDR
13788449: [6.6.y,4/4] selftests: mptcp: join: check re-adding init endp
with != id:
    - Series: Backport of "selftests: mptcp: join: test for flush/re-add
endpoints" and more
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=886198&state=*&archive=both

13788450: [6.6.y] mptcp: pr_debug: add missing \n at the end:
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240903100957.3368081-2-matttbe@kernel.org/

13788453: [6.6.y,1/2] mptcp: make pm_remove_addrs_and_subflows static
13788454: [6.6.y,2/2] mptcp: pm: fix RM_ADDR ID for the initial subflow:
    - Series: Backport of "mptcp: pm: fix RM_ADDR ID for the initial
subflow"
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=886201&state=*&archive=both

13788455: [6.6.y] mptcp: avoid duplicated SUB_CLOSED events:
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240903101747.3377518-2-matttbe@kernel.org/

13788456: [6.6.y] selftests: mptcp: join: cannot rm sf if closed:
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240903101845.3378766-2-matttbe@kernel.org/

13788471: [6.6.y,1/3] selftests: mptcp: add mptcp_lib_events helper
13788472: [6.6.y,2/3] selftests: mptcp: join: validate event numbers
13788473: [6.6.y,3/3] selftests: mptcp: join: check re-re-adding ID 0
signal:
    - Series: Backport of "selftests: mptcp: join: validate event
numbers" and more
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=886206&state=*&archive=both

13790502: [6.1.y] mptcp: pm: fullmesh: select the right ID later:
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240904105627.4074381-2-matttbe@kernel.org/

13790503: [6.1.y] mptcp: pm: avoid possible UaF when selecting endp:
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240904105721.4075460-2-matttbe@kernel.org/

13790509: [6.1.y,1/2] mptcp: pm: reuse ID 0 after delete and re-add
13790510: [6.1.y,2/2] mptcp: pm: fix ID 0 endp usage after multiple
re-creations:
    - Series: [6.1.y] mptcp: pm: avoid possible UaF when selecting endp
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=886733&state=*&archive=both

13790511: [6.1.y] selftests: mptcp: join: validate fullmesh endp on 1st sf:
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240904110430.4084188-2-matttbe@kernel.org/

13790512: [6.1.y] selftests: mptcp: join: check re-using ID of closed
subflow:
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240904110510.4085066-2-matttbe@kernel.org/

13790515: [6.1.y,1/2] selftests: mptcp: add explicit test case for
remove/readd
13790516: [6.1.y,2/2] selftests: mptcp: join: test for flush/re-add
endpoints:
    - Series: [6.1.y,1/2] mptcp: pm: reuse ID 0 after delete and re-add
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=886736&state=*&archive=both

13790517: [6.1.y] selftests: mptcp: join: check re-using ID of unused
ADD_ADDR:
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240904110705.4087459-2-matttbe@kernel.org/

13790518: [6.1.y] selftests: mptcp: join: check re-adding init endp with
!= id:
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240904110830.4089238-2-matttbe@kernel.org/

13790519: [6.1.y] mptcp: pr_debug: add missing \n at the end:
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240904110926.4090424-2-matttbe@kernel.org/

13790520: [6.1.y,1/2] mptcp: make pm_remove_addrs_and_subflows static
13790521: [6.1.y,2/2] mptcp: pm: fix RM_ADDR ID for the initial subflow:
    - Series: [6.1.y,1/2] mptcp: make pm_remove_addrs_and_subflows static
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=886742&state=*&archive=both

13790534: [6.1.y] mptcp: avoid duplicated SUB_CLOSED events:
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240904111113.4092725-2-matttbe@kernel.org/

13790535: [6.1.y] selftests: mptcp: join: check removing ID 0 endpoint:
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240904111201.4093743-2-matttbe@kernel.org/

13790536: [6.1.y] selftests: mptcp: join: no extra msg if no counter:
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240904111233.4094425-2-matttbe@kernel.org/

13790537: [6.1.y] selftests: mptcp: join: check re-re-adding ID 0 endp:
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240904111302.4095059-2-matttbe@kernel.org/

13790540: [6.1.y] selftests: mptcp: join: cannot rm sf if closed:
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240904111548.4098486-2-matttbe@kernel.org/

13790866: [6.6.y,1/2] selftests: mptcp: join: disable get and dump addr
checks
13790867: [6.6.y,2/2] selftests: mptcp: join: stop transfer when check
is done (part 2.2):
    - Series: Fixes for recent backports
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=886822&state=*&archive=both

13792478: [6.1.y,1/3] selftests: mptcp: fix backport issues
13792479: [6.1.y,2/3] selftests: mptcp: join: validate event numbers
13792480: [6.1.y,3/3] selftests: mptcp: join: check re-re-adding ID 0
signal:
    - Series: selftests: mptcp: fix backport issues
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=887284&state=*&archive=both

13793684: [5.15.y] mptcp: pm: re-using ID of unused flushed subflows:
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240906082853.1764704-2-matttbe@kernel.org/

13793685: [5.15.y] mptcp: pm: only decrement add_addr_accepted for MPJ req:
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240906083000.1766120-2-matttbe@kernel.org/

13793686: [5.15.y] mptcp: pm: check add_addr_accept_max before accepting
new ADD_ADDR:
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240906083043.1767111-2-matttbe@kernel.org/

13793687: [5.15.y] mptcp: pm: fullmesh: select the right ID later:
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240906083123.1767956-2-matttbe@kernel.org/

13793688: [5.15.y,1/2] mptcp: constify a bunch of of helpers
13793689: [5.15.y,2/2] mptcp: pm: avoid possible UaF when selecting endp:
    - Series: [5.15.y,1/2] mptcp: constify a bunch of of helpers
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=887621&state=*&archive=both

13793690: [5.15.y] mptcp: pr_debug: add missing \n at the end:
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240906083242.1769743-2-matttbe@kernel.org/

13793691: [5.15.y] mptcp: pm: skip connecting to already established sf:
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240906083308.1770314-2-matttbe@kernel.org/

13793692: [5.15.y] mptcp: pm: send ACK on an active subflow:
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240906083334.1770934-2-matttbe@kernel.org/

13793693: [5.15.y] mptcp: pm: do not remove already closed subflows:
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240906083401.1771515-2-matttbe@kernel.org/

13793694: [5.15.y] mptcp: avoid duplicated SUB_CLOSED events:
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240906083430.1772159-2-matttbe@kernel.org/

13793695: [5.15.y] mptcp: pm: ADD_ADDR 0 is not a new address:
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240906083454.1772761-2-matttbe@kernel.org/

13793696: [5.15.y] mptcp: close subflow when receiving TCP+FIN:
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240906083520.1773331-2-matttbe@kernel.org/

13793736: [5.10.y] mptcp: pm: avoid possible UaF when selecting endp:
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240906092222.1930688-2-matttbe@kernel.org/

13793737: [5.10.y] mptcp: pr_debug: add missing \n at the end:
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240906092255.1931435-2-matttbe@kernel.org/

13794674: [net-next,v2,1/5] selftests: mptcp: lib: add time per subtests
in TAP output
13794675: [net-next,v2,2/5] selftests: mptcp: connect: remote time in
TAP output
13794676: [net-next,v2,3/5] selftests: mptcp: reset the last TS before
the first test
13794677: [net-next,v2,4/5] selftests: mptcp: diag: remove trailing
whitespace
13794678: [net-next,v2,5/5] selftests: mptcp: connect: remove duplicated
spaces in TAP output:
    - Series: selftests: mptcp: add time per subtests in TAP output
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=887871&state=*&archive=both

13797514: [net-next,1/3] mptcp: export mptcp_subflow_early_fallback()
13797515: [net-next,2/3] mptcp: fallback to TCP after SYN+MPC drops
13797516: [net-next,3/3] mptcp: disable active MPTCP in case of blackhole:
    - Series: mptcp: fallback to TCP after 3 MPC drop + cache
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=888573&state=*&archive=both

13798201: [net,V4] mptcp: pm: Fix uaf in __timer_delete_sync:
    - Submitter: Edward Adam Davis
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/tencent_7142963A37944B4A74EF76CD66EA3C253609@qq.com/
    - Directly applied in netdev

13799263: [net,1/3] selftests: mptcp: join: restrict fullmesh endp on 1st sf
13799264: [net,2/3] selftests: mptcp: include lib.sh file
13799265: [net,3/3] selftests: mptcp: include net_helper.sh file:
    - Series: selftests: mptcp: misc. small fixes
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=889048&state=*&archive=both

13800082: [net] netlink: specs: mptcp: fix port endianness:
    - Submitter: Asbjørn Sloth Tønnesen
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240911091003.1112179-1-ast@fiberby.net/
    - Directly applied in netdev


    our repo (by: Gang Yan, Geliang Tang, Matthieu Baerts):

13786935: [mptcp-next,1/3] mptcp: export mptcp_subflow_early_fallback()
13786936: [mptcp-next,2/3] mptcp: fallback to TCP after SYN+MPC drops
13786937: [mptcp-next,3/3] mptcp: disable active MPTCP in case of blackhole:
    - Series: mptcp: fallback to TCP after 3 MPC drop + cache
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=885758&state=*&archive=both

13791615: [mptcp-next,v8,1/4] Squash to "selftests/bpf: Add mptcp
subflow example"
13791616: [mptcp-next,v8,2/4] selftests/bpf: Add getsockopt to inspect
mptcp subflow
13791617: [mptcp-next,v8,3/4] Squash to "selftests/bpf: Add mptcp
subflow subtest"
13791618: [mptcp-next,v8,4/4] Squash to "selftests/bpf: Add bpf
scheduler test":
    - Series: fixes for "new MPTCP subflow subtest v4"
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=887030&state=*&archive=both

13794470: [mptcp-next,1/2] selftests: mptcp: diag: remove trailing
whitespace
13794471: [mptcp-next,2/2] selftests: mptcp: connect: remove duplicated
spaces in TAP output:
    - Series: selftests: mptcp: add time per subtests in TAP output (part 2)
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=887838&state=*&archive=both

13795727: [mptcp-next] mptcp: Add data race when accessing the
fully_established of subflow:
    - Submitter: Gang Yan
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/tencent_604F30643CD92D084CEB0AA3BE951B30C009@qq.com/

13795752: [mptcp-next,v2,1/4] Squash to "bpf: Add bpf_mptcp_sched_ops"
13795753: [mptcp-next,v2,2/4] Squash to "selftests/bpf: Add mptcp
subflow subtest"
13795754: [mptcp-next,v2,3/4] Squash to "selftests/bpf: Add bpf
scheduler test"
13795755: [mptcp-next,v2,4/4] Squash to "selftests/bpf: Add bpf_burst
scheduler & test":
    - Series: cleanups for bpf schedulers
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=888199&state=*&archive=both

13795802: [mptcp-next,1/2] mptcp: implement mptcp_pm_connection_closed
13798798: [mptcp-next] Squash to "selftests/bpf: Add mptcp subflow subtest":
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240910152907.2538-2-matttbe@kernel.org/

13798955: [mptcp-net,1/3] selftests: mptcp: join: restrict fullmesh endp
on 1st sf
13798956: [mptcp-net,2/3] selftests: mptcp: include lib.sh file
13798957: [mptcp-net,3/3] selftests: mptcp: include net_helper.sh file:
    - Series: selftests: mptcp: misc. small fixes
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=888987&state=*&archive=both

13801861: [net-next] memory-provider: fix compilation issue without SYSFS:
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240912-net-next-fix-get_netdev_rx_queue_index-v1-1-d73a1436be8c@kernel.org/
    - a different version has been applied later on

13806683: [mptcp-next,v2,2/6] Squash to "selftests/bpf: Add mptcp
subflow subtest"
13808996: [mptcp-next,v3,1/3] Squash to "selftests/bpf: Add getsockopt
to inspect mptcp subflow"
    - Submitter: Geliang Tang

13811073: [mptcp-next] Squash to "DO-NOT-MERGE: mptcp: improve code
coverage for CI":
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240924-mptcp-gcov-v1-1-b259d5dc5fa6@kernel.org/



Pending patches:
    - The list of pending patches can be seen on PatchWork:
      https://patchwork.kernel.org/project/mptcp/list/?state=*


    netdev (if mptcp ML is in cc) (by: Geliang Tang, Matthieu Baerts,
Yunsheng Lin):

13665648: [bpf-next,v2,1/8] selftests/bpf: Add unshare_netns helper
13665649: [bpf-next,v2,2/8] selftests/bpf: Use unshare_netns helper
13665650: [bpf-next,v2,3/8] selftests/bpf: Drop duplicate create_netns
13665651: [bpf-next,v2,4/8] selftests/bpf: Export create_netns helper
13665652: [bpf-next,v2,5/8] selftests/bpf: Use create_netns helper
13665653: [bpf-next,v2,6/8] selftests/bpf: Export cleanup_netns helper
13665654: [bpf-next,v2,7/8] selftests/bpf: Use cleanup_netns helper
13665655: [bpf-next,v2,8/8] selftests/bpf: Use netns helpers in lwt tests:
    - Series: add netns helpers
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=853539&state=*&archive=both
    - keep or drop?

13689188: [RESEND,v2] checkpatch: skip warnings for symbol links:
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/dc502b1b45cb27fda48d72d73e3267a32db023d8.1717722648.git.tanggeliang@kylinos.cn/

13793537: [net-next,v18,12/14] net: replace page_frag with page_frag_cache:
    - can be reviewed?

13800807: [bpf-next/net,v6,1/3] selftests/bpf: Add mptcp subflow example
13800808: [bpf-next/net,v6,2/3] selftests/bpf: Add getsockopt to inspect
mptcp subflow
13800809: [bpf-next/net,v6,3/3] selftests/bpf: Add mptcp subflow subtest:
    - Series: selftests/bpf: new MPTCP subflow subtest
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=889409&state=*&archive=both
    - A new version can be sent → Done

13805597: [6.1.y] selftests: mptcp: join: restrict fullmesh endp on 1st sf:
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240916154836.565586-2-matttbe@kernel.org/

13805928: [5.10.y,1/3] mptcp: export lookup_anno_list_by_saddr
13805929: [5.10.y,2/3] mptcp: validate 'id' when stopping the ADD_ADDR
retransmit timer
13805930: [5.10.y,3/3] mptcp: pm: Fix uaf in __timer_delete_sync:
    - Series: Backport of "mptcp: pm: Fix uaf in __timer_delete_sync"
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=890839&state=*&archive=both


    our repo (by: Asbjørn Sloth Tønnesen, Cong Wang, Geliang Tang,
Gregory Detal, Matthieu Baerts, Paolo Abeni):

12282219: [RESEND,RFC,2/4] tcp: move selected mptcp helpers to tcp.h/mptcp.h
12282221: [RESEND,RFC,4/4] tcp: parse tcp options contained in reset
packets:
12282223: [RESEND,RFC,mptpcp-next] mptcp: add ooo prune support:
12282225: [RESEND,1/5] tcp: make two mptcp helpers available to tcp stack
12282227: [RESEND,5/5] mptcp: send fastclose if userspace closes socket
with unread data:

13070467: [mptcp-next,v4,1/2] mptcp: update mptcp_push_release
13070468: [mptcp-next,v4,2/2] mptcp: retrans for redundant sends:
    - State: Changes requested
    - Series: BPF redundant scheduler, part 3
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=703615&state=*&archive=both

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

13583230: [RFC] mptcp: react scheduler when subflow events pop up:
    - State: Changes requested
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/433320c3a9db77bea53a34fc9c43a3c7e3320399.1709693691.git.tanggeliang@kylinos.cn/

13656189: [mptcp-net,v2] mptcp: fix the default value of scaling_ratio:
    - State: Changes requested
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/0ccc1c26d27d6ee7be22806a97983d37c6ca548c.1715053270.git.tanggeliang@kylinos.cn/

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

13729347: [mptcp-next,1/3] mptcp: add mptcp_snd_nxt helper
13729348: [mptcp-next,2/3] Squash to "bpf: Export more bpf_burst related
functions"
13729349: [mptcp-next,3/3] Squash to "selftests/bpf: Add bpf_burst
scheduler":
    - State: Changes requested
    - Series: get msk->snd_nxt with READ_ONCE
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=870130&state=*&archive=both

13750069: [mptcp-next,1/4] selftests: mptcp: add cfg_timeo for mptcp_connect
13750070: [mptcp-next,2/4] selftests: mptcp: add io thread mode for
mptcp_connect
13750071: [mptcp-next,3/4] selftests: mptcp: enable io thread mode
13750072: [mptcp-next,4/4] selftests: mptcp: join: add io thread tests:
    - State: Changes requested
    - Series: add io thread mode tests
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=875830&state=*&archive=both

13785276: [mptcp-net] mptcp: pm: do not remove closing subflows:
    - State: New
    - Submitter: Matthieu Baerts
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240830-mptcp-pm-minor-fixes-v1-1-89737b847a8d@kernel.org/
    - Needs review
    - (removes duplicated 'Fixes' tag)

13792383: [mptcp-next] Squash to "selftests/bpf: Add getsockopt to
inspect mptcp subflow":
    - State: Rejected
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/11a224e1bade27689271af77cd47c6a49852a2cf.1725543947.git.tanggeliang@kylinos.cn/

13795803: [mptcp-next,2/2] mptcp: add back mptcp_pm_subflow_closed:
    - State: Changes requested
    - Series: update PM event CLOSED handlers
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=888215&state=*&archive=both

13799664: [mptcp-next,v3] Squash to "selftests/bpf: Add bpf scheduler
test" - drop has_bytes_sent:
    - State: New
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/a92cdca650b2e3e6ea40e783331d1fe83ac9aae6.1726026758.git.tanggeliang@kylinos.cn/

13799666: [net,v2] mptcp: initialize sock lock with its own lockdep keys:
    - State: New
    - Submitter: Cong Wang
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240911042425.978665-1-xiyou.wangcong@gmail.com/
    - Needs review:
        - Matth: looks OK, maybe one suggestion to avoid a double init?
        - Matth: might be better if someone else can look at this.

13803165: [net-next] tools: ynl-gen: use big-endian netlink attribute types:
    - State: Changes requested
    - Submitter: Asbjørn Sloth Tønnesen
    - URL:
https://patchwork.kernel.org/project/mptcp/patch/20240913085555.134788-1-ast@fiberby.net/
    - Handled upstream

13810556: [mptcp-next,v6,01/10] bpf: Register mptcp common kfunc set
13810557: [mptcp-next,v6,02/10] bpf: Add mptcp_subflow bpf_iter
13810558: [mptcp-next,v6,03/10] bpf: Add mptcp_sock acquire and release
helpers
13810559: [mptcp-next,v6,04/10] selftests/bpf: Add mptcp_subflow
bpf_iter test prog
13810560: [mptcp-next,v6,05/10] selftests/bpf: More endpoints for
endpoint_init
13810561: [mptcp-next,v6,06/10] selftests/bpf: Add mptcp_subflow
bpf_iter subtest
13810562: [mptcp-next,v6,07/10] Squash to "selftests/bpf: Add bpf
scheduler test"
13810563: [mptcp-next,v6,08/10] Squash to "mptcp: add sched_data helpers"
13810564: [mptcp-next,v6,09/10] Squash to "bpf: Export more bpf_burst
related functions"
13810565: [mptcp-next,v6,10/10] Squash to "selftests/bpf: Add bpf_burst
scheduler & test":
    - State: New
    - Series: add mptcp_subflow bpf_iter
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=892355&state=*&archive=both
    - To be reviewed

13810582: [mptcp-next,1/8] Squash to "mptcp: add sched_data helpers"
13810583: [mptcp-next,2/8] Squash to "bpf: Add bpf_mptcp_sched_kfunc_set"
13810584: [mptcp-next,3/8] Squash to "selftests/bpf: Add bpf_first
scheduler & test"
13810585: [mptcp-next,4/8] Squash to "selftests/bpf: Add bpf_bkup
scheduler & test"
13810586: [mptcp-next,5/8] Squash to "selftests/bpf: Add bpf_rr
scheduler & test"
13810587: [mptcp-next,6/8] Squash to "selftests/bpf: Add bpf_red
scheduler & test"
13810588: [mptcp-next,7/8] Squash to "selftests/bpf: Add bpf_burst
scheduler & test"
13810589: [mptcp-next,8/8] mptcp: drop subflow contexts in mptcp_sched_data:
    - State: New
    - Series: use bpf_iter in bpf schedulers
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=892365&state=*&archive=both
    - To be reviewed

13810891: [mptcp-next,1/2] mptcp: drop skb parameters in get_addr interfaces
13810892: [mptcp-next,2/2] mptcp: drop skb parameters in set_flags
interfaces:
    - State: New
    - Series: drop skb parameters in pm interfaces
    - Submitter: Geliang Tang
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=892457&state=*&archive=both

13811801: [mptcp-net,1/2] mptcp: handle consistently DSS corruption.
13811803: [mptcp-net,2/2] tcp: fix mptcp DSS corruption due to large
pmtu xmit.:
    - State: New
    - Series: [mptcp-net,1/2] mptcp: handle consistently DSS corruption.
    - Submitter: Paolo Abeni
    - URL:
https://patchwork.kernel.org/project/mptcp/list/?series=892713&state=*&archive=both




Issues on GitHub:
    https://github.com/multipath-tcp/mptcp_net-next/issues/

    Recently opened (latest from the last meeting: 515):
        /

    Recently discussed:

  489  IPv6 Rejoin Subflow [question]
  484  BPF: `setsockopt` on an MPTCP socket: check support [bug] [bpf]
@geliangtang
  469  CI: add code coverage support [enhancement] [CI]
  416  No new subflow when removing an endpoint and adding a new one
[bug] [feedback-needed]
   74  BPF: path manager [enhancement] [pm] [bpf] @geliangtang


    Bugs (opened, flagged as "bug" and assigned)

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

  513  [syzbot] WARNING in `__mptcp_move_skbs_from_subflow` [bug]
[syzkaller]
  508  Divide error on device removal [bug] [feedback-needed]
  505  Subflows won't be used when the interface for the main flow is a
subinterface [bug] [feedback-needed]
  501  Why do endpoint tcp connections close? [bug] [feedback-needed]
  499  selftests: `mptcp_connect.sh`: disconnect test timed out [bug]
[selftests]
  498  in-kernel PM: closed subflows before `RM_ADDR` will not decrement
`add_addr_accepted` [bug] [pm]
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
  416  No new subflow when removing an endpoint and adding a new one
[bug] [feedback-needed]
  336  Issues with BPF packet scheduler [bug] [sched] [bpf]
  325  selftests: `mptcp_join`: test 18 `signal addresses race test` is
sometimes failing [bug] [selftests]
  324  selftests: `mptcp_join`: tests `fastclose test` & `fastclose
server test` are sometimes failing [bug] [selftests]
  315  Issues with backup flow [bug]


    In Progress (opened, new feature and assigned)

  480  MPTCP and KTLS support [enhancement] @geliangtang
  434  in-kernel PM: increase subflows limit [enhancement] [pm] @matttbe
  353  sockopt: uniform code to get/set values [enhancement] @matttbe
  349  scheduler: (un)mark a subflow as "stale" [enhancement] [sched]
@geliangtang
  296  Support IP_TTL & IPV6_UNICAST_HOPS [enhancement] @matttbe
  234  Packetdrill: Support MPC+DATA+checksum error [enhancement]
[packetdrill] @spoorva
  167  packetdrill: add coverage for RM_ADDR [enhancement] [packetdrill]
@dcaratti
   75  BPF: packet scheduler [enhancement] [sched] [bpf] @geliangtang
   74  BPF: path manager [enhancement] [pm] [bpf] @geliangtang


    Assigned Questions (opened, questions and assigned)

None.


    Open questions (opened, questions and not assigned)

  502  Question for ip-mptcp command [question]
  489  IPv6 Rejoin Subflow [question]
  459  Are the endpoint flags `signal` and `subflow` meant to be
exclusive? or how to get MPTCP to work for both directions? [question]
  452  mptcp causes the network to become very slow [question]
  412  shadowsocks-libev not working, need guidance for PM configuration
[question]
  411  Problem with IPROTO [question]


    For later (opened and not assigned)

  515  Add `TCP_MAXSEG` socket option support [enhancement]
  514  Add MIB counters for fallback to TCP in the middle of a
connection [enhancement]
  511  Add MIB counters for sent `MPTCP_RST_EMPTCP` [enhancement]
  503  in-kernel PM: use endpoints only to create subflows with received
`ADD_ADDR` [enhancement] [pm]
  497  in-kernel PM: check to create new subflows when some are
destroyed [enhancement] [pm]
  496  in-kernel PM: store received `ADD_ADDR` [enhancement] [pm]
  481  remove refcount on TCP sockets for the timers [enhancement]
  469  CI: add code coverage support [enhancement] [CI]
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
  397  Doc and guidance for users [enhancement] [documentation]
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
  333  New MIBs to help understanding issues when PM cannot create new
subflows [enhancement] [pm]
  332  scheduler: implement a "opportunistic retransmission"
[enhancement] [sched]
  298  CG Memory accounting for passive MPTCP socket [enhancement]
  289  mptcp: audit comments for non inclusive language [enhancement]
  273  Packetdrill: test outgoing MP_FASTCLOSE [enhancement] [packetdrill]
  266  Packetdrill: add MP_FAIL coverage [packetdrill]
  236  Review supported sockopts list [enhancement]
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


    Recently closed (since 20240828)

  517  Round-Robin Packet Scheduler Support
  516  Annotate data-races around  `subflow->fully_established` [bug]
  477  Client: fallback to TCP after X MPC [bug] @matttbe
   57  After a few attempts of failed MPTCP, directly fallback to TCP
for new connections [enhancement]


    Packetdrill PRs

  153  1 month ago  matttbe   mptcp: tfo: inject DFIN without delay
  52   3 years ago  dcaratti  Add initial coverage for RM_ADDR


    mptcp.dev PRs

   /

    mptcpd PRs

    /


FYI: Current Roadmap:
    - Bugs:
https://github.com/multipath-tcp/mptcp_net-next/issues?q=is%3Aissue+is%3Aopen+label%3Abug
    - Current/Coming merge window (6.12):
https://github.com/orgs/multipath-tcp/projects/10
    - For later: https://github.com/orgs/multipath-tcp/projects/1



Patches to send to NetDev:

    - Fixes for other trees: /

    - Fixes for -net: /

    - Fixes for net-next: /

    - Features for net-next:

        - [368fe04e57e2] mptcp: pm: send ACK on non stale subflows
(Matthieu Baerts (NGI0))
        - [6c1973205152] mptcp: annotate data-races around
subflow->fully_established (Gang Yan)
        - [d7906f95649d] mptcp: implement mptcp_pm_connection_closed
(Geliang Tang):
            - net-next is currently closed

    - Features for net-next (next): /

    - Features for other trees:

        - [25bfd83fa60d] mptcp: add sched_data helpers (Geliang Tang)
        - [aaf4d0a92f0a] bpf: Add bpf_mptcp_sched_ops (Geliang Tang)
        - [aef27cd167ee] bpf: Add bpf_mptcp_sched_kfunc_set (Geliang Tang)

        - [9ae6863b38d8] selftests/bpf: Add mptcp subflow example
(Nicolas Rybowski)
        - [e1e3107eaa9d] selftests/bpf: Add getsockopt to inspect mptcp
subflow (Geliang Tang)
        - [60b09c403f34] selftests/bpf: Add mptcp subflow subtest
(Geliang Tang):
            - TODO: Matth: send upstream → Done

        - [07e9a0801a04] selftests/bpf: Add bpf scheduler test (Geliang
Tang)
        - [39dfd676d57c] selftests/bpf: Add bpf_first scheduler & test
(Geliang Tang)
        - [4534103b7ce4] selftests/bpf: Add bpf_bkup scheduler & test
(Geliang Tang)
        - [fe6b3a5cfeb9] selftests/bpf: Add bpf_rr scheduler & test
(Geliang Tang)
        - [daf98629cc88] selftests/bpf: Add bpf_red scheduler & test
(Geliang Tang)
        - [e62d0cc247ac] bpf: Export more bpf_burst related functions
(Geliang Tang)
        - [3a258aa129b3] selftests/bpf: Add bpf_burst scheduler & test
(Geliang Tang)



Extra tests:
    - news about Syzkaller? (Christoph):
        - /

    - Packetdrill (Davide):
        - /

    - Patchew (Davide):
        - /

    - CI (Matth):
        - https://ci-results.mptcp.dev/flakes.html
            - looks OK
        - https://netdev.bots.linux.dev/flakes.html?tn-needle=mptcp
            - looks OK
        - GCOV coming:
            - https://ci-results.mptcp.dev/lcov/export/index.html



Reset instead of a fallback:
    - Seen by Christoph
    - Traces have been taken. Next step: packetdrill test
    - TODO: Matth: follow-up on that



Next meeting:
    - Next one on Wednesday, the 2nd of October.
    - 17:30 UTC (8.30am PDT, 5.30pm CEST, 11.30pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20241002



Feel free to comment on these topics and suggest new ones for the next
meeting!

Talk to you on Wednesday,
Matt
-- 
Sponsored by the NGI0 Core fund.

