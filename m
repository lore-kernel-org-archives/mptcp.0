Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795742279;
	b=fgRiRIWUrWFP9PTokWFPKGNeHoTm+iByfk2uv1lmLpUK6s8g+Zc4ZNWIzfsBC467wqXJ
	 YtsimM01E7NEUo61k916zoSQ4hfeeIut0/1itx+vAzWJsMue6Go71zrCzZRlylwWH/+fJ
	 wiEZ6hmHFOj8llU7e8afgJGwIhUwH5UN2pDVaCn6nCr8kIwHXgPEzrjG5df+FqNpGawzM
	 WeHlQEDjEogwRF4WYeRm+buZtCBzBn8kaMz9nP5qg8W2MjD8N/4jkc1B+OzAedbJl2WL8
	 15ZQsoqd7Vu/RWc0e6p1pekw3lNVNoYGWKhGI8bHtssLeqzcGA30s+Xe5qL5aNrEmHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795742279;
	h=Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Content-Type:User-Agent:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zWsq7quUgjqbp/gtxEB2QnqEiko+2mnOaviyKF5VOwg=;
	b=TBjc71QIWyuHwXhEssGAe5ploHpKfVcLIJ0P3Fh5qrlq6PmG/nZk9bSTy4fge/VsQcLr
	 araKQpHcin/G5OctrPaR4cWBaN1BNl3XCin59LDQ7hYJIaNlZCWl9eHO2vfL/kNA3HW+p
	 LUnBwGDC9ynmn/cL0N+Q9FhZ/ReLQAc+9Jv5AZFSnguVDwKKZytfVOYGW89G0+OzPQfHT
	 2hX500cqAJLjubCKR9nBSEgY3e0gUIscrr40utXjb3do85iKZXt2wVeQrA8Ph5N4Xs53K
	 1Q+23MyjWK7IKdNP7uD9j3c1EHuryb7kOoT0Hph29isK2UGCV0PZFwGiBEzETDCsKsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Ju/ITPxO";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64822606A31C
	for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 01:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ju/ITPxO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D14BD1F000C1;
	Fri, 27 Nov 2026 01:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795742279;
	bh=zWsq7quUgjqbp/gtxEB2QnqEiko+2mnOaviyKF5VOwg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Ju/ITPxOmfLwcK+ASMIz9P5wAbCbOE8DRcJl6q25OPVm82MxcO3L140HADR3jIsTx
	 NJ16cPd6bSL22TixqaMfBkOIPM/vT++RWF4NZCTb48W7Zj7HMbkO/Vc53+7iztBNrf
	 X++02hh80c3JisPLpxvecPPjvi8flC8nOtpCISlpT6etvBYIeTqR75kM0NW4ahjcPa
	 iFydA/TdaeI0KsCiUiSfVsSROJBoiLJtIbe6B6p9yOlqBRGCOuQvpJzFAOkVdggNZk
	 jMAEP519G2vQw0WnBG/1UEAZ4bPIWPIJUrbvQsoJw7twfveB1NJNER+HvPDsoIK/OP
	 eOY9OyPs+z8AQ==
Message-ID: <9cd6e922fff2072fca01653f02bf4775fc6b79d1.camel@kernel.org>
Subject: Re: [PATCH mptcp-net v3 22/50] mptcp: close a subflow reset for a
 bad mapping
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Linux
	 <mptcp@lists.linux.dev>
Cc: Chris Mason <mason@kernel.org>
Date: Fri, 27 Nov 2026 09:17:55 +0800
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-22-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
	 <20261124-mptcp-cmason-fixes-v3-22-416c0920c73f@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-10build1 
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hi Matt,

On Tue, 2026-11-24 at 22:59 +0100, Matthieu Baerts (NGI0) wrote:
> From: Chris Mason <mason@kernel.org>
> 
> An MPTCP socket can stay in the ESTABLISHED state after MPTCP has reset
> its only subflow because of data with no valid mapping, and recv() and
> send() then block with no error.
> 
> If data arrives with no valid mapping and a fallback to TCP is not
> possible, subflow_check_data_avail() resets the subflow: it moves the
> TCP socket to TCP_CLOSE with tcp_set_state() and sends a RST. The MPTCP
> worker then has to close the subflow in __mptcp_close_subflow(), and
> closing the last subflow starts a timer that moves the MPTCP socket to
> TCP_CLOSE. But the worker only calls that function if the bit
> MPTCP_WORK_CLOSE_SUBFLOW is set, and this reset neither sets the bit nor
> schedules the worker.
> 
> The fix used here is to call subflow_sched_work_if_closed() after the
> reset, which sets the bit and schedules the worker. This also covers
> the reset done after a bad checksum, when MP_FAIL cannot be used.
> 
> This issue has been found with the help of an LLM, and reproduced in a
> VM, with the reproducer shared with the original version of this patch,
> and with a new Packetdrill test: data without DSS while the fallback is
> not possible, here because of out-of-order data at the MPTCP level.
> Without this patch, the subflow was reset, but the MPTCP socket stayed
> established, with no subflow: read() returned EAGAIN and send() timed
> out, for good:
> 
>   dss_drop_ooo_reset_server.pkt:30: runtime error in read call: Expected errno 107 (Transport endpoint is not connected) but got 11 (Resource temporarily unavailable)
> 
> Fixes: 40947e13997a ("mptcp: schedule worker when subflow is closed")
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ Add a Fixes tag. Moved before "mptcp: continue the last mapping after
>   a fallback", which makes this reset path reachable in more cases.
>   Commit message: how the issue was found, and its symptoms. ]
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Looks good to me!

    Reviewed-by: Geliang Tang <geliang@kernel.org>

Thanks,
-Geliang

> ---
> v2: commit msg: the reset after a bad checksum too (Sashiko)
> ---
>  net/mptcp/subflow.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 91698d154c40..a216d88d35ee 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1505,8 +1505,8 @@ static bool subflow_check_data_avail(struct sock *ssk)
>  		}
>  
>  		if (!mptcp_try_fallback(ssk, MPTCP_MIB_DSSFALLBACK)) {
> -			/* fatal protocol error, close the socket.
> -			 * subflow_error_report() will introduce the appropriate barriers
> +			/* fatal protocol error, reset the subflow and let the
> +			 * worker close it
>  			 */
>  			subflow->reset_transient = 0;
>  			MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DSSRESET);
> @@ -1521,6 +1521,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
>  				sk_eat_skb(ssk, skb);
>  			mptcp_send_active_reset_reason(ssk);
>  			WRITE_ONCE(subflow->data_avail, false);
> +			subflow_sched_work_if_closed(msk, ssk);
>  			return false;
>  		}
>  	}
