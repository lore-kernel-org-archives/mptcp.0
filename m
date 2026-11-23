Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795415554;
	b=hYxlY9sYXAx3XchFPf+g6dRovAvsrNrWid6aDWTdqvhxeIw8pm4suUfTkEPW4Vyaoxfw
	 HlQ1wbiCM+7yOs/WkG5D1mhKRSVmqMOQQhJtm6xdCVIfoy21gB7UpevKMODD0yqwWSUz4
	 snaJVrMNsctoUYzcSZgneRntFYCYk9IFsDDiRZLWIiZ8g8dON2bpHQyIZuTg0kCkVoBKv
	 j5G4Vu4+j8u1VgrBxgsBcZi9gDhRVM4GIoMT65bCsI5BPgH1KgmHmye+bzifAQsZ00yad
	 lLiND/mKLO2Cj4Ei6GJ0r0a1lJgreT6x20i4bX1Hro9rYWRiyCF0frc8mugCUt5NiPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795415554;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=MCWm7uaHfRwhk8fSxvgvyXd1iGJ/sZZr+m3P7Vt3yn0=;
	b=Jr3j8BYJXIIMSiAfyK2Htn9koIWANPppsP5JRyW6WD8um7iA/ksjKHMtuJX/aFCqdUVu
	 RoGsY+c5rjBtlclsFfOdRSmNlRvhqdmrHoRPKfLRBFEtBH7cjkywcZ8bL40ft8aPDnfD+
	 /0SAM7hjktpFRyKq6Dda7guWE5+T0yPIHoVbQPHPJCjzmL89gapxoYSbvPS4PSALS97Dp
	 POh/fYRhG2ZgBMsaE3xA6ZQGstfqAYLzR9Do26Rd5494J7shvomVWMrap7CA6hkBizvsH
	 c51pFXWW5Pz8Wn4sYKDKKn+TR/oTaoQ3T1SV/7BYf2DSy1eDSw+frEJ71TpWIO2KIAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HW0VqIue;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B83606A31A
	for <mptcp@lists.linux.dev>; Mon, 23 Nov 2026 06:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HW0VqIue
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0974F1F000E6;
	Mon, 23 Nov 2026 06:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795415554;
	bh=MCWm7uaHfRwhk8fSxvgvyXd1iGJ/sZZr+m3P7Vt3yn0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HW0VqIueNeP2TSKFyygMHYN4w4ak3opl+JhApUNJ8HFHWqqODZeUE/aVeCLB/DvFn
	 LUdWtu/8BZFK6AVORrxaxMzVp5lxTOz3L7yhyVgdDRVUaPR0eCD9h1zZwaUhqlk5Q0
	 2fxQ95fhRzL5+M2idM/UyBIR5MMg24nEecUUI+/LjUK64ZLjMIMrjg8BZTVT3qljhh
	 bX+Cq5vhOS8r/0g8Crd3qbzKiqmDOfimQZ/Lnk/BT2oaYAc1SIrl0GtZWisXwDCck8
	 WTiJ2M8Ro03Pln8f9ZZUrWhX9e4QUtL+5D5wkOG99k295l5CI3is76+iRYZKuH/BHa
	 CLkhnQ18/QU3g==
Subject: Re: [PATCH mptcp-net v2 29/62] mptcp: keep listening after
 MSG_FASTOPEN errors
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Mon, 23 Nov 2026 06:32:33 +0000
Message-ID: <179541555362.3133.15360891097208549475@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-29-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-29-00327fd1de1f@kernel.org>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] This patch is incomplete.

--

mptcp: keep listening after MSG_FASTOPEN errors

This patch skips the mptcp_disconnect() retry in mptcp_sendmsg_fastopen()
when the msk is a listener. A failed sendmsg() with MSG_FASTOPEN then no
longer closes an MPTCP listener. The retry exists to redo a disconnect
that failed inside __inet_stream_connect().

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 55ff0298e5dd2..6f4e418d712c8 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2004,11 +2004,12 @@ static int mptcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
>  		 */
>  		if (ret && ret != -EINPROGRESS && ret != -ERESTARTSYS && ret != -EINTR)
>  			*copied_syn = 0;
> -	} else if (ret && ret != -EINPROGRESS) {
> +	} else if (ret && ret != -EINPROGRESS && sk->sk_state != TCP_LISTEN) {

[Severity: High]
Does the TCP_LISTEN check fully cover the case described in the commit
message, where there is nothing to retry?

__inet_stream_connect() calls disconnect() in only two places. One is
the AF_UNSPEC branch, which tcp_sendmsg_fastopen() already rejects. The
other is the sock_error label:

sock_error:
	err = sock_error(sk) ? : -ECONNABORTED;
	sock->state = SS_UNCONNECTED;
	sk->sk_disconnects++;
	if (sk->sk_prot->disconnect(sk, flags))
		sock->state = SS_DISCONNECTING;

Other errors return without trying a disconnect. One example:

	case SS_CONNECTED:
		err = -EISCONN;
		goto out;

The same is true of -EINVAL, and of the -EOPNOTSUPP, -EALREADY and
-ENOBUFS returns in tcp_sendmsg_fastopen(), which happen before
__inet_stream_connect() is called. For a msk that is not a listener,
the mptcp_disconnect() retry still runs for all of these errors.

This sequence looks reachable:

  - an established MPTCP socket calls shutdown(SHUT_WR), and the msk
    goes to FIN_WAIT1, then FIN_WAIT2
  - the peer sends data, then a DATA_FIN. mptcp_check_data_fin() moves
    the msk to TCP_CLOSE. sock->state stays SS_CONNECTED, and the data
    stays unread in sk_receive_queue
  - the application calls send(fd, buf, len, MSG_FASTOPEN)
  - __mptcp_nmpc_sk() accepts TCPF_CLOSE.
    tcp_sendmsg_fastopen()->__inet_stream_connect() returns -EISCONN
    from the SS_CONNECTED case without trying a disconnect
  - back in mptcp_sendmsg_fastopen(), sk_state is TCP_CLOSE rather than
    TCP_LISTEN, so mptcp_disconnect(sk, 0) runs. It succeeds because
    fastopening is 0 by then

mptcp_disconnect()->mptcp_destroy_common() then does:

	__skb_queue_purge(&sk->sk_receive_queue);
	skb_rbtree_purge(&msk->out_of_order_queue);

On top of that:

  - the subflows are fast-closed
  - the token and PM state are destroyed
  - sk_shutdown and SOCK_DONE are cleared
  - the socket is forced to SS_UNCONNECTED

Userspace sees only -EISCONN, but the unread data and the EOF are gone.
Plain TCP returns -EISCONN via sk_stream_error() and leaves the socket
and its data untouched.

The same unwanted disconnect seems to happen on a TCP_CLOSE msk when the
TFO client sysctl is disabled and tcp_sendmsg_fastopen() returns
-EOPNOTSUPP.

Would it make sense to retry only when a disconnect really failed?
__inet_stream_connect() sets sock->state to SS_DISCONNECTING in exactly
that case. Another option is for mptcp_disconnect() to record that it
returned -EBUSY.

Either check would also cover the listener, which stays SS_UNCONNECTED.
It could then replace the TCP_LISTEN check instead of being added next
to it.

This code appears unchanged at the end of the series.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f%40kernel.org
