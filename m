Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10053DD84C;
	Tue,  6 Oct 2026 18:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791309952; cv=none; b=NJ1qbQ2ebHDXoEQzzIEiJOj2Lc9zsPOSDbjZhffYoxmQOSUY3M3PLrwZFURVsBpDlaisq9CALB+4g8Il9Gt4pWVj1n1Ov6w3H0+27t+YPuySp+s9UiUbPBfOxhsa1BBsviB2Me55TLRMb3KCTFyg0DEvAmdy4pNZgrXTsLiTURA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791309952; c=relaxed/simple;
	bh=zd7yaBoRPmh0Q656XDfXeX0avuKhzjMKvz/ysJcYtPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qh7ZdH29WiCdyJoHLbM0mcv0jpiqrRxyHHK1qmBcWdee94D9uwRI4G8OIkfwbC81rHjfJIqD+IBtlkUf9TEJEhO6/v3AlxnXVI0nerA069mnSuzsACFwFWeXzSnIkF+L3+g7AveRgHXnKiojsN9F8a1h4OE5N2DIGg+XbRNNIMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jphCwQ4m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jphCwQ4m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BE7A1F0089D;
	Tue,  6 Oct 2026 18:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791309950;
	bh=1v3tJEqqvQC3iOAaN6J8by9TOY9l6x10mSgdjL7Xhb4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=jphCwQ4maJhBwKEYz4+H8BN9WcdGru1ZcyZ3H+xd7fd3Cz3MKlpzFcdhY8oWw2jE9
	 R+PhwvYpNRPudi+OvC4O3EP+HqGzUUTZ2lncYOX4D3u4m0nG8Oj59MrN63SHHWYU1U
	 hB1jcYhm2+ecoAUtPhh3yB3Y1ccyavdNQU8zHC1lEUGkkVgW4aboIHSDx+UxMChvnX
	 1yVtO1ksYrLt4Y+36Ib1oJC306qHkyxnlDWtAmlRBfP8bmteRTwCtapzDCSHQ5ci4U
	 iHAvd3MKYEqq/5m0p75HW194T2lKa7hXHm/Cs5xpNg3rrtNThs567GT0B9lL6m+GNv
	 avLMoenkDziOg==
Message-ID: <f66560e3-b821-4e70-980b-d3a6252a022d@kernel.org>
Date: Tue, 6 Oct 2026 20:05:43 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net v6 0/2] mptcp: fix request migration ownership
Content-Language: fr
To: Ren Wei <weir@nebusec.ai>, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 geliang@kernel.org
Cc: martineau@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ncardwell@google.com,
 kuniyu@google.com, daniel@iogearbox.net, kafai@fb.com, kylebot@openai.com,
 david.lee@trailofbits.com, vega@nebusec.ai, caoruide123@gmail.com
References: <cover.1788800732.git.caoruide123@gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <cover.1788800732.git.caoruide123@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ren, Ruide,

On 08/09/2026 18:41, Ren Wei wrote:
> TCP request migration clones pending requests with inet_reqsk_clone(). Some
> MPTCP request fields carry ownership which cannot be duplicated by a plain
> byte copy.
> 
> For MP_JOIN requests, subflow_req->msk holds a socket reference. The clone
> inherits the pointer without acquiring its own reference, so the original
> and cloned requests can drop the same reference. Patch 1 lets the cloned
> request acquire a reference while verifying that the original request still
> owns the same msk.
> 
> For MP_CAPABLE requests, token_node belongs to the original request and is
> hashed in the token table. Copying the node gives the clone invalid hash
> state. Patch 2 moves token ownership under the bucket lock and makes token
> acceptance and destruction tolerate an already moved token.

Thank you for your patience. It looks like we were waiting for Clashiko
report, but it didn't get processed for some unknown reason, sorry about
that.

The patches look good to me, I suggest taking them in the MPTCP tree,
and I will send them later on.

Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

(...)

> // poc for MP_JOIN:

Thank you for the PoCs using packetdrill! Do you mind creating a PR to
add them in the MPTCP fork, please:

  https://github.com/multipath-tcp/packetdrill/

(if it is an issue, please tell me, I can add them later)

> 
> // Minimal reproducer for a stale subflow_req->msk after reqsk migration.
> --tolerance_usecs=200000

Usually, 100000 is used. Do you need more?

> --non_fatal=packet

Why do you need this?
> `sysctl -q net.mptcp.enabled=1

This one is not needed, you can use '../common/defaults.sh' instead.

> sysctl -q net.ipv4.tcp_migrate_req=1
> sysctl -q net.ipv4.tcp_synack_retries=1`
> 
> // Listener A and the owning MPTCP connection.
> +0     socket(..., SOCK_STREAM, IPPROTO_MPTCP) = 3
> +0     setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
> +0     setsockopt(3, SOL_SOCKET, SO_REUSEPORT, [1], 4) = 0
> +0     bind(3, ..., ...) = 0
> +0     listen(3, 8) = 0
> 
> +0.0   <  addr[caddr0] > addr[saddr0]  S   0:0(0)         win 65535  <mss 1460, sackOK, TS val 1000 ecr 0,    nop, wscale 8, mpcapable v1 flags[flag_h] nokey>

(When validating the listener side, you can drop the TCP TS options,
except if you do need them, clearer with less options)

> +0.0   >                               S.  0:0(0)  ack 1             <mss 1460, sackOK, TS val 1000 ecr 1000, nop, wscale 8, mpcapable v1 flags[flag_h] key[skey]>
> +0.1   <                                .  1:1(0)  ack 1  win 256    <nop, nop, TS val 1000 ecr 1000, mpcapable v1 flags[flag_h] key[ckey=2, skey]>
> +0     accept(3, ..., ...) = 4
> 
> // Make the MPTCP socket fully established so it accepts MP_JOIN.
> +0.1   <                               P.  1:3(2)  ack 1  win 256    <nop, nop, TS val 1001 ecr 1000, mpcapable v1 flags[flag_h] key[skey, ckey] mpcdatalen 2, nop, nop>
> +0.0   >                                .  1:1(0)  ack 3             <nop, nop, TS val 1001 ecr 1001, dss dack8=3 dll=0 nocs>
> 
> // Leave exactly one MP_JOIN request half-open.
> +0.1   <  addr[caddr1] > addr[saddr0]  S   0:0(0)         win 65535  <mss 1460, sackOK, TS val 2000 ecr 0,    nop, wscale 8, mp_join_syn address_id=1 token=sha256_32(skey)>
> +0.0   >                               S.  0:0(0)  ack 1             <mss 1460, sackOK, TS val 2000 ecr 2000, nop, wscale 8, mp_join_syn_ack address_id=0 sender_hmac=auto>
> 
> // Listener B joins the reuseport group, then A is closed. The next request
> // timer clones and migrates the half-open MP_JOIN request to B.
> +0.1   socket(..., SOCK_STREAM, IPPROTO_MPTCP) = 5
> +0     setsockopt(5, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
> +0     setsockopt(5, SOL_SOCKET, SO_REUSEPORT, [1], 4) = 0
> +0     bind(5, ..., ...) = 0
> +0     listen(5, 8) = 0
> +0     close(3) = 0
> 
> // Wait past the first SYN+ACK RTO, then release the owning MPTCP socket.
> +1.5   setsockopt(4, SOL_SOCKET, SO_LINGER, {onoff=1, linger=0}, 8) = 0
> +0     close(4) = 0
> 
> // The migrated request expires on its next timer and its destructor uses msk.
> +4.0   `true`
> 
> ------------------------------
> crash log of MP_JOIN> [  280.449259] [      C0] BUG: KASAN: slab-use-after-free in
subflow_req_destructor (net/mptcp/subflow.c:45)

If such calltrace is on public ML, please, next time, include this in
the commit message instead (without the prefixes between []). I will
amend it in the commit message.

(...)
> MP_CAPABLE packetdrill reproducer:
> 
> // Reproducer for MP_CAPABLE request token ownership during TCP req migration.
> //
> // The first listener owns the request created by the MP_CAPABLE SYN.  A second
> // SO_REUSEPORT listener is added only after that SYN, then the first listener is
> // closed.  The SYN+ACK retransmission timer migrates the request to the second
> // listener, and a later request timer destroys the migrated request.
> //
> // On a vulnerable kernel, inet_reqsk_clone() raw-copies token_node.  The clone
> // is not the token table owner, so destroying the migrated request triggers the
> // MPTCP token ownership bug.
> --tolerance_usecs=250000
> 
> +0     `sysctl -q net.mptcp.enabled=1`
> +0     `sysctl -q net.ipv4.tcp_migrate_req=1`
> +0     `sysctl -q net.ipv4.tcp_synack_retries=2`
> +0     `sysctl -q net.ipv4.tcp_timestamps=1`
> +0     `sysctl -q kernel.panic_on_warn=0`
> +0     `sysctl -q kernel.panic_on_oops=0`
> +0     `ip tcp_metrics flush all >/dev/null 2>&1 || true`
> +0     `tc qdisc replace dev tun0 root pfifo >/dev/null 2>&1 || true`

You probably only require tcp_migrate_req=1 here, after
../common/defaults.sh.

> +0     socket(..., SOCK_STREAM, IPPROTO_MPTCP) = 3
> +0     setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
> +0     setsockopt(3, SOL_SOCKET, SO_REUSEPORT, [1], 4) = 0
> +0     getsockopt(3, SOL_TCP, TCP_IS_MPTCP, [1], [4]) = 0
> +0     bind(3, ..., ...) = 0
> +0     listen(3, 1) = 0
> 
> +0       <  S   0:0(0)         win 32792  <mss 1000, sackOK, nop, nop, nop, wscale 7, mpcapable v1 flags[flag_h] nokey>
> +0       >  S.  0:0(0)  ack 1             <mss 1460, nop, nop, sackOK, nop, wscale 9, mpcapable v1 flags[flag_h] key[skey]>

"wscale 9" is "strange". Note that you can launch tests with run_all.py,
e.g.

  # ./packetdrill/run_all.py -lv mptcp/<subdir>/<test>.pkt

> +0     socket(..., SOCK_STREAM, IPPROTO_MPTCP) = 4
> +0     setsockopt(4, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
> +0     setsockopt(4, SOL_SOCKET, SO_REUSEPORT, [1], 4) = 0
> +0     getsockopt(4, SOL_TCP, TCP_IS_MPTCP, [1], [4]) = 0
> +0     bind(4, ..., ...) = 0
> +0     listen(4, 1) = 0
> 
> +0     close(3) = 0
> 
> // Let the retransmission timer migrate the request to fd 4 and let the migrated
> // request expire.  On vulnerable kernels its raw-copied token_node is not the
> // token-table owner, so the request timer trips the token owner assertion.
> +8.0   `true`

If you set `sysctl -q net.ipv4.tcp_synack_retries=0`, can you reduce
this to 2 seconds instead of 8?

> +0     close(4) = 0
> 
> ------------------------------
> decoded warning from MP_CAPABLE reproducer:

Same here, I will add it in the commit messages.

> [  314.661418] [      C2] ------------[ cut here ]------------
> [  314.661636] [      C2] WARNING: net/mptcp/token.c:364 at mptcp_token_destroy_request+0x2b0/0x330, CPU#2: swapper/2/0
> [  314.661931] [      C2] CPU: 2 UID: 0 PID: 0 Comm: swapper/2 Not tainted 7.2.0-rc5-00353-gc27e36054537 #10 PREEMPT(full)
> [  314.662092] [      C2] RIP: 0010:mptcp_token_destroy_request (build/../net/mptcp/token.c:364 (discriminator 1))
> [  314.663001] [      C2] Call Trace:
> [  314.663043] [      C2]  <IRQ>
> [  314.663107] [      C2]  subflow_v4_req_destructor (build/../net/mptcp/subflow.c:694)
> [  314.663213] [      C2]  __reqsk_free (build/../net/ipv4/inet_connection_sock.c:906)
> [  314.663325] [      C2]  reqsk_timer_handler (build/../include/net/request_sock.h:137 build/../net/ipv4/inet_connection_sock.c:1147)
> [  314.663762] [      C2]  call_timer_fn (build/../kernel/time/timer.c:1748)
> [  314.668915] [      C2] ---[ end trace 0000000000000000 ]---

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

