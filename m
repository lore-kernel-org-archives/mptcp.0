Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175333D994
	for <mptcp@lists.linux.dev>; Sun, 21 Jun 2026 15:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782054835; cv=none; b=rQskfYYoVuUEg3r6AFkU3W7P0U8fJW/HGRHB0fbVtGwGTCDWcx44Mx4yucwtzCX6WLHTCmUv8QFXyRgurB4YzVwlzA1ztR0c/x57W8BWTap4EU/KnBDdkY84zhgAetQS8haVoNzb6HL17INbAjyPCoCYLWTOE5XKboqk4BSkQXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782054835; c=relaxed/simple;
	bh=XuoFskI3SADUmsv24myZ4p0Jb1DE8dIQht4/4SG2Eto=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UwzcMIiXNMo/bBjhdxHlK1KF3W+s+/Id2InAD17vkN5aQdGrmYZ0kLgSEPXmIfXDvtuw4zlEMODjCQDzPKdhKD8Ai2nZr/iq7lVyjt0wKD87LubBKLq8Ns0Kj0FVun4BKA5x/+WJR4OB6YPEU8nUAGtCjszr4oxHFLTMoPjzfHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YBTNErDr; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YBTNErDr"
Message-ID: <8f289a50-eaf9-45c9-b0e5-fdb70131636e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782054830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6K/34pST0tI7fjJg8NJo7Atv1W2HT1tIjg8sf4SeAlE=;
	b=YBTNErDrgPrgZTiec/hCt5k15p/xN3JebM5FmuAg3rqE7lM3Pu6u9CUIDONuauNyH+J9I+
	dnC5tkLOGpNSjWkyIDMCxtz7oI9kX6PyhCdtXlePq96E3/y06cqlGRreWTxDkVqHptDS/J
	sfr1ljBcIxNyQMk2lbdS8n/OTVir6lE=
Date: Sun, 21 Jun 2026 23:13:38 +0800
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Cc: cui.tao@linux.dev, janak <janak@mpiric.us>,
 kalpanjani009 <kalpanjani009@gmail.com>, martineau <martineau@kernel.org>,
 matttbe <matttbe@kernel.org>, mptcp <mptcp@lists.linux.dev>,
 pabeni <pabeni@redhat.com>, "shardul.b" <shardul.b@mpiricsoftware.com>,
 shardulsb08 <shardulsb08@gmail.com>, cuitao <cuitao@kylinos.cn>,
 syzbot+55c2a5c871441261ed14
 <syzbot+55c2a5c871441261ed14@syzkaller.appspotmail.com>
Subject: Re: [PATCH net v3] mptcp: pm: drop pending ADD_ADDR when removing id
 0 endpoint
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
References: <20260529085415.1562229-1-kalpan.jani@mpiricsoftware.com>
 <20260618001035.1701878-1-cui.tao@linux.dev>
 <19edecf7b26.8016d4fc87564.6167938013625579685@mpiricsoftware.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <19edecf7b26.8016d4fc87564.6167938013625579685@mpiricsoftware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


Hi Kalpan,

Thanks a lot for the kind words, and for the fast and thoughtful reply!

On the entry port: sorry, my printk label was a bit cryptic and probably
misleading -- the stored entry port is 0, not 1. The signal endpoint is
added with no port (`ip mptcp endpoint add 10.0.1.1 signal`), so the
anno_list entry is keyed with port 0; the "=1" in my log line was just
the boolean result of the lookup (entry found), not a port value. So your
instinct is right: clearing the port matches, and that is the minimal fix
for the no-port case.

For completeness, the reasoning I relied on: the lookup inside
mptcp_pm_announced_remove() is mptcp_addresses_equal(..., use_port = true),
and a lookup with port 0 returned "found" -- which can only happen if the
entry's own port is 0. With msk_local (port 5000 here) it returns "not
found", the teardown is skipped and the WARN still fires.

That said, I fully agree with your point about the with-port case: if a
signal endpoint ever carries a port, zeroing wouldn't match either, and
the address-only lookup variant would be the robust choice. Either is fine
by me; I'll defer to whatever you and Matthieu prefer for v4.

Here is the repro, written as a kselftest so it can double as the
regression test you mentioned. I've run it in a QEMU/KVM VM on this tree:
it fails ("not ok", new WARNING: net/mptcp/pm in dmesg) on the unpatched
kernel and passes ("ok") once the id 0 removal drops the pending ADD_ADDR.
The sequence is deterministic:

  - keep the connection alive with a bidirectional /dev/zero stream so
    both ends are fully established;
  - signal 10.0.2.1 so the peer joins -- this gives a second subflow
    (without it the connection is torn down when id 0 is removed) and
    lets mptcp_mpc_endpoint_setup() account the MPC endpoint first, so
    that 10.0.1.1 actually gets selected and announced as id 0;
  - signal 10.0.1.1 (the MPC address) -> anno_list entry created;
  - del id 0 10.0.1.1;
  - signal 10.0.3.1 to force a reselection, which hits the stale entry
    on unpatched kernels.

--->8 (mptcp_id0_stale_anno.sh) ---
#!/bin/bash
# SPDX-License-Identifier: GPL-2.0

# Regression test for the syzbot "WARNING in mptcp_pm_alloc_anno_list" bug
# (extid 55c2a5c871441261ed14): removing the id 0 endpoint used to leave a
# pending ADD_ADDR anno_list entry alive, and a later PM reselection
# re-announced that address, tripping the WARN_ON_ONCE(mptcp_pm_is_kernel())
# in mptcp_pm_announced_alloc().
#
# The test keeps an MPTCP connection alive and fully established, then:
#   1. signals 10.0.2.1 so the peer joins (a second subflow keeps the
#      connection alive across the id 0 removal) and the MPC endpoint
#      accounting is done;
#   2. signals the MPC address 10.0.1.1, announced as id 0 (anno_list entry);
#   3. removes id 0 10.0.1.1;
#   4. signals 10.0.3.1 to force a reselection, which hits the stale entry on
#      unpatched kernels.
#
# It fails (new WARNING: net/mptcp/pm in dmesg) on unpatched kernels and passes
# once the id 0 removal drops the pending ADD_ADDR.

. "$(dirname "${0}")/mptcp_lib.sh"

ret=0
ns1=""
ns2=""
err=$(mktemp)
timeout_poll=30
port=50000

# This function is used in the cleanup trap
#shellcheck disable=SC2317,SC2329
cleanup()
{
	rm -f "${err}"
	mptcp_lib_ns_exit "${ns1}" "${ns2}"
}

mptcp_lib_check_mptcp
mptcp_lib_check_tools ip

trap cleanup EXIT

mptcp_lib_ns_init ns1 ns2

# A single veth pair with three subnets: the peer can join each signalled
# address and the connection survives the id 0 removal thanks to the join.
ip link add ns1eth1 netns "${ns1}" type veth peer name ns2eth1 netns "${ns2}"
ip -net "${ns1}" link set lo up
ip -net "${ns2}" link set lo up
ip -net "${ns1}" link set ns1eth1 up
ip -net "${ns2}" link set ns2eth1 up
ip -net "${ns1}" addr add 10.0.1.1/24 dev ns1eth1
ip -net "${ns1}" addr add 10.0.2.1/24 dev ns1eth1
ip -net "${ns1}" addr add 10.0.3.1/24 dev ns1eth1
ip -net "${ns2}" addr add 10.0.1.2/24 dev ns2eth1
ip -net "${ns2}" addr add 10.0.2.2/24 dev ns2eth1
ip -net "${ns2}" addr add 10.0.3.2/24 dev ns2eth1

mptcp_lib_pm_nl_set_limits "${ns1}" 8 8
mptcp_lib_pm_nl_set_limits "${ns2}" 8 8

# Keep the connection alive and fully established on both ends for the whole
# sequence below (a bidirectional /dev/zero stream). It is stopped explicitly
# once the reselection has been forced.
ip netns exec "${ns1}" ./mptcp_connect -t "${timeout_poll}" -l -p "${port}" \
	0.0.0.0 < /dev/zero > /dev/null 2>"${err}" &
spid=$!
mptcp_lib_wait_local_port_listen "${ns1}" "${port}"
ip netns exec "${ns2}" ./mptcp_connect -t "${timeout_poll}" -p "${port}" \
	10.0.1.1 < /dev/zero > /dev/null 2>"${err}" &
cpid=$!

sleep 2

# Count MPTCP PM warnings before the sequence.
warn_before=$(dmesg | grep -c "WARNING: net/mptcp/pm")

# 1. signal 10.0.2.1: peer joins -> second subflow + mpc endpoint accounted.
mptcp_lib_pm_nl_add_endpoint "${ns1}" 10.0.2.1 flags signal
sleep 2
# 2. signal the MPC address 10.0.1.1: announced as id 0 (anno_list entry).
mptcp_lib_pm_nl_add_endpoint "${ns1}" 10.0.1.1 flags signal
sleep 1
# 3. remove id 0: leaves the stale anno_list entry on unpatched kernels.
mptcp_lib_pm_nl_del_endpoint "${ns1}" 0 10.0.1.1
sleep 1
# 4. force a reselection: hits the stale entry on unpatched kernels.
mptcp_lib_pm_nl_add_endpoint "${ns1}" 10.0.3.1 flags signal
sleep 2

warn_after=$(dmesg | grep -c "WARNING: net/mptcp/pm")

# The connection has served its purpose; stop it so the test can finish.
kill "${cpid}" "${spid}" 2>/dev/null
wait "${cpid}" 2>/dev/null
wait "${spid}" 2>/dev/null

if [ "${warn_after}" -gt "${warn_before}" ]; then
	mptcp_lib_result_fail "no stale ADD_ADDR warning on id 0 removal"
	ret=1
else
	mptcp_lib_result_pass "no stale ADD_ADDR warning on id 0 removal"
fi

mptcp_lib_result_print_all_tap

exit ${ret}
---8<---

The temporary printk I used in mptcp_nl_remove_id_zero_address() was:

        anno_addr = msk_local;
        pr_info("DBG id0: msk_local.port=%u\n", ntohs(msk_local.port));
        anno_addr.port = 0;
        announced = mptcp_pm_announced_remove(msk, &anno_addr);
        pr_info("DBG id0: announced(port0_lookup)=%d\n", announced);

which printed `msk_local.port=5000` / `announced(port0_lookup)=1`.

If the repro above ends up forming the test, please feel free to reuse/adapt it as you see
fit.

Happy to test v4 here once it's posted.

在 2026/6/19 15:36, Kalpan Jani 写道:
> 
> Hi Tao,
> 
> Thanks a lot for digging into this -- this is a real bug in the patch, not noise.
> 
> You're right: msk_local carries the connection's local port, and the lookup in
> mptcp_pm_announced_remove() compares with use_port = true, so passing msk_local
> directly fails to match the pending entry from a no-port signal endpoint. The
> teardown then never runs and the WARN still fires on reselection. So v3 as-is is
> effectively a no-op in this configuration -- thanks for catching it.
> 
> I haven't reproduced it deterministically on my side yet, so I'd gladly take you
> up on the repro you mentioned -- please share it. I'll run it with a printk in
> the id 0 path to confirm the stored entry port and the announced result before
> and after the fix.
> 
> One detail I want to nail down with that: your note says the entry is "keyed with
> port 1", but the suggested fix zeroes the port (anno_addr.port = 0). If the entry
> port is really 0, clearing the port as you suggested matches and is the minimal
> fix; if it turns out non-zero, zeroing wouldn't match either and the address-only
> lookup variant would be needed instead. The repro will let me check which it is.
> 
> I'll fold the fix into v4 (rebased onto current export, where the helper is
> mptcp_pm_announced_remove()), add a regression test based on the repro, and credit
> you with a Suggested-by. If the repro ends up forming the test, I'll coordinate the
> right tags with you.
> 
> Cheers,
> Kalpan Jani
> 
> 
> From: Tao Cui <cui.tao@linux.dev>
> To: <kalpan.jani@mpiricsoftware.com>
> Cc: <janak@mpiric.us>, <kalpanjani009@gmail.com>, <martineau@kernel.org>, <matttbe@kernel.org>, <mptcp@lists.linux.dev>, <pabeni@redhat.com>, <shardul.b@mpiricsoftware.com>, <shardulsb08@gmail.com>, <cui.tao@linux.dev>, <cuitao@kylinos.cn>, <syzbot+55c2a5c871441261ed14@syzkaller.appspotmail.com>
> Date: Thu, 18 Jun 2026 05:40:34 +0530
> Subject: Re: [PATCH net v3] mptcp: pm: drop pending ADD_ADDR when removing id 0 endpoint
> 
>  > From: Tao Cui <cuitao@kylinos.cn>
>  > 
>  > Hi Kalpan,
>  > 
>  > First of all, thanks for this patch!
>  > 
>  > While playing with it on top of the current tree, I think I may have
>  > bumped into a small detail, and I just wanted to mention it in case it
>  > is useful — please do correct me if I got any of this wrong.
>  > 
>  > After the "mptcp: pm: uniform announced addresses helpers" refactor
>  > (7d4dacc8ccca), the helper became mptcp_pm_announced_remove(), and its
>  > lookup uses mptcp_addresses_equal(..., /* use_port = */ true). A pending
>  > ADD_ADDR entry coming from a signal endpoint added without a port
>  > (`ip mptcp endpoint add ADDR signal`) is keyed with port 1, while
>  > msk_local carries the connection's local port. With a listener on port
>  > 5000, a temporary printk in the id 0 path shows:
>  > 
>  >     msk_local.port = 5000
>  >     announced(port0_lookup) = 1
>  > 
>  > So, at least in this configuration, passing msk_local directly does not
>  > match the entry: the stale entry survives, and the WARN still shows up
>  > on the next reselection. It only goes away when the port is ignored
>  > during the lookup.
>  > 
>  > If that matches what you see, the smallest change that keeps the v3
>  > shape would be to clear the port before the lookup, something like:
>  > 
>  >         struct mptcp_addr_info anno_addr = msk_local;
>  > 
>  >         anno_addr.port = 0;
>  >         announced = mptcp_pm_announced_remove(msk, &anno_addr);
>  > 
>  > (An address-only variant of the lookup might be a touch cleaner, since a
>  > signal entry never carries the connection port — but the one-liner above
>  > is enough to fix the case I reproduced.)
>  > 
>  > I have a small repro that triggers it deterministically if it would help
>  > — happy to share.
>  > 
>  > Thanks again for looking into this, and sorry for the noise if I'm
>  > missing something obvious here.
>  > 
>  > Cheers,
>  > Tao
>  > 
> 

