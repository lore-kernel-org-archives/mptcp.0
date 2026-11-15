Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794739987;
	b=p1QqslEnygr7L+07XUbRzgfdnnYoMswDhPKZSU4ANC9Rn2RFcw/8VhOVF6Uv/qWdqf+D
	 Lx0kRTdQLwC2dY31DuFIzn4qhkdoa3NajYa/qGXOLsuJfy1gbHWQu5Qm0neju29WtQRvt
	 pV9EYQNMQIFZFhwFXdVWyvUPsLh1gdkLaS2IgASTvqrRFKcyNuJpUwwenGEAG/KwUbiS/
	 JrFPsroOEOYXGfrQxUN81MQq/Jx4ZPYluj1eaJQmXD15XPqAyS2gxzSoUtV8e5ilrLMaH
	 A9wgwDjeJ2ABZtjykuE5rop5hUyEg9/Q4irNR93Ld1m3BEAMOYIKKie3ijRPJLXB/tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794739987;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=uaz5n234OHtBXckYcH8rYYXtqRvahtirVV86tNYyZ1w=;
	b=HSBhD41L8/YmrQi0m3fPofSs7rrRa4eRGn/VzA2160z4Y302RQaSJ05DkLgecsfWW8mo
	 jvUfwiD9wssZix2y8urdeX9llTGk+XnlbULyy+zA8pkSkdmzEZl6qdPYx9V8hDchjYvMR
	 VU/wkPBvq7B5DVbaWGN/5j5OrImqqqhQwPpRN+SRF3RoHxxkaFigz4KfRRCTgQs3/GZ6d
	 L72XKJyrUg8L5tyxITh6A7kJMy0p+gHSO9+Rf+aCs/oGIX7JcsS6LeQOYsR17GhG+PI+K
	 zuJmfoPXugzR0aWVGTcmzPwfMylVWWLCNmWGDpsiIbw6Tccwmi6FdRPUc/VCXat3kIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mEymcB1U;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F092606A31A
	for <mptcp@lists.linux.dev>; Sun, 15 Nov 2026 10:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mEymcB1U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A289E1F000C7;
	Sun, 15 Nov 2026 10:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794739986;
	bh=uaz5n234OHtBXckYcH8rYYXtqRvahtirVV86tNYyZ1w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mEymcB1URQ/xCHzNKm1+Z3SmbUTQLF0e9ewKtb3UYHx6C6xt8iRDb9Qky7xAOyFaQ
	 9N+kp+OEb7YEvCvgB1qoHnxUEt0Je7MODoXfaXPKFPdhhLP8+6vBv3U38BVChY7yDi
	 HKuJItLShW8p9nc3bXxmikCvPS3AqhjDCuIq35X23JADL1M4Z7qE9VqnqiIWOfm+57
	 85FE0DOjt/fT19HibsXoEX/uN1CCkYokUJCWfa9VeOfHjIYEY1hR5AKe9HVr+O2JHi
	 YuhBdWUbiAsDAnf3kzJp33u5mIqQfaV/L72Qvq0adgJje1R8f2kGTSHjxdanHdH72m
	 dN8P+SuaeQGDg==
Subject: Re: [PATCH mptcp-net 05/34] mptcp: pm: don't drop an RM_ADDR behind a
 pending one
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc:
 mptcp@lists.linux.dev, mason@kernel.org, pabeni@redhat.com, kuba@kernel.org
Date: Sun, 15 Nov 2026 10:53:06 +0000
Message-ID: <179473998624.488855.11483341374426124974@kernel.org>
In-Reply-To: <20261113-mptcp-cmason-fixes-v1-5-9205b77e9a2f@kernel.org>
References: <20261113-mptcp-cmason-fixes-v1-5-9205b77e9a2f@kernel.org>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In net/mptcp/pm.c, mptcp_pm_rm_addr_received() sends an
  MPTCP_EVENT_REMOVED genl event for every id in the incoming RM_ADDR…

--

mptcp: pm: don't drop an RM_ADDR behind a pending one

When an RM_ADDR arrives before the PM worker has consumed the previous
one, this patch merges the new remote ids into the pending rm_list_rx
instead of dropping the whole option. Only ids that do not fit in the
MPTCP_RM_IDS_MAX slots are dropped, and RmAddrDrop is counted in that
case.

> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index cdc8bab0eaf80..32885e80486ee 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c

[ ... ]

> @@ -852,8 +853,20 @@ void mptcp_pm_rm_addr_received(struct mptcp_sock *msk,
>  
>  	spin_lock_bh(&pm->lock);
>  	if (mptcp_pm_schedule_work(msk, MPTCP_PM_RM_ADDR_RECEIVED))
> -		pm->rm_list_rx = *rm_list;
> -	else
> +		pm->rm_list_rx.nr = 0;
> +
> +	/* the worker may not have got to the previous RM_ADDR yet */
> +	for (i = 0; i < rm_list->nr; i++) {
> +		if (memchr(pm->rm_list_rx.ids, rm_list->ids[i],
> +			   pm->rm_list_rx.nr))
> +			continue;
> +		if (pm->rm_list_rx.nr == MPTCP_RM_IDS_MAX) {
> +			drop = true;
> +			break;
> +		}

[Severity: Medium]
Can ids that hit this overflow branch still get an MPTCP_EVENT_REMOVED
event for an address whose subflows are kept?

Earlier in mptcp_pm_rm_addr_received(), before pm->lock is taken, an
event is sent for every received id:

	for (i = 0; i < rm_list->nr; i++)
		mptcp_event_addr_removed(msk, rm_list->ids[i]);

Once pm->rm_list_rx.nr reaches MPTCP_RM_IDS_MAX, the remaining ids are
never queued. mptcp_pm_worker()->mptcp_pm_rm_addr_recv() then never
closes their subflows, but user space has already been told they are
gone.

The netlink spec for the removed event in mptcp_pm.yaml says "An address
has been lost by the peer". The commit message describes this mismatch
as the bug being fixed:

  "counted as RmAddrDrop and forgotten, although the netlink events for
  its ids have been sent already ... The subflows to the second address
  stay."

The peer can trigger this. Two or more RM_ADDR options with more than 8
distinct ids in total, arriving before the worker runs, leave the extra
ids in this state.

Would it work to send the events after the merge loop, and only for ids
that were actually queued or were already pending?

A smaller related point: an id that is already pending and skipped by
the memchr() check above still gets a second removed event, although
only one removal happens. Is that intended?

> +		pm->rm_list_rx.ids[pm->rm_list_rx.nr++] = rm_list->ids[i];
> +	}
> +	if (drop)
>  		__MPTCP_INC_STATS(sock_net((struct sock *)msk), MPTCP_MIB_RMADDRDROP);
>  	spin_unlock_bh(&pm->lock);
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f%40kernel.org
