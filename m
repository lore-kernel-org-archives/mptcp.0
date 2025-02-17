Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A74218ADD
	for <mptcp@lists.linux.dev>; Mon, 17 Feb 2025 11:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739792036; cv=none; b=RDnGkRr235B6+ggqRPiVySxTTt3jHOTDAhWZZI90LjIybaQaPLjY3mxe85ineCDxgz53ktVIM5vGsdoaDh9jY92lclXDMfySHvhnWhauT1I9Sh313ObujrqgceXsn8cdvLMqDeZpRahrCHFfydsU0RcyBBys42flcEH/ySDvn44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739792036; c=relaxed/simple;
	bh=f3qoDDuXW/lr23ho0Iuc3QvNhVgb2XhAmH9yu6iW8/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c08YiT4ab86nJZpEG3AzeOqT/cOdM/33+L9RENUZwEfY09+x4JRfNI1oCkjK7B7qC6bLwMuJtowzOg7RdKjK/InGP7L/5SVPEWlZyss4LzljNi90EpCKnUk1CKGxvxMeg4FYFgDdL9Q6Gu7lVvzF19pOXW/6KiFkITBaGy336EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xpedite-tech.com; spf=pass smtp.mailfrom=xpedite-tech.com; dkim=temperror (0-bit key) header.d=xpedite-tech.com header.i=@xpedite-tech.com header.b=OHSvZHbg; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xpedite-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xpedite-tech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=xpedite-tech.com header.i=@xpedite-tech.com header.b="OHSvZHbg"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3f3eb93c2f6so1094434b6e.1
        for <mptcp@lists.linux.dev>; Mon, 17 Feb 2025 03:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xpedite-tech.com; s=google; t=1739792034; x=1740396834; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+6jErYZPQP20ys6VmxaF5EWI033bPb2NsD3HM3qDj4c=;
        b=OHSvZHbgXelepgaO81VQVmVigFD43WWhQiFmFbE6IR3CqxGD586iW0tdDnIzdQr2hn
         0H5Mp5pnEYc2DaheIx6PX4gPCs4r63f5Kc6ytw65kkRVC37nYc/IduMFZSmvHLS/+bs9
         MsplrgdGyYcT62+Ri43fl6Rb+Zodw3AtsYStaE0cxFUaJ4xd4Htqpb74fO3bThaLeXyT
         ROatHghXLbvWwenW+rzjREXg4NTyOnaXLsHKi+peCc9+GhurAelH7C2lAuGs7uTCBxQi
         UsK12xg/TuEMAtNSXtn5ESl9Rz4ZfgAS6yz7dtXqm4KzTwPQlyquluQI3FuBcbm7yQ/s
         +z2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739792034; x=1740396834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+6jErYZPQP20ys6VmxaF5EWI033bPb2NsD3HM3qDj4c=;
        b=VJ2Sh9SWbXNnoGH5AJiZbtRTydpb618fLz8FJ5pgqlER3aFclWRwOC9m3IsoE9e1je
         1+TpwmviQ2cwzS412kQd9hyiBO1FA5F3G50UFazlCYquZW3y9ObnRPhQxPGdBf0gWw+j
         vseW1qf0QdfwU+mqucIAhaQmg3dYwIVYtA3hlD6dEU47aQkLbsA/37U1j9wAFF/O7kZR
         nb4iGfMetvUTD7fVWpbkRJ90CSPtycyTW4aERrK4WyvsjnlbUcsoFti5KjnJNZkvkJXV
         7412nxzRbdLhv3+3gm+05E2YOTVEY7ZJnGjmQ3oD6tZcxITAiU3UUpbjpKjVwbSCCacF
         PHEw==
X-Gm-Message-State: AOJu0Yw2BX8AE4UswW62sFxQ2qroG+JnwU8fTWJ2vGudwRUhKCMCnPAz
	CXtr4kd3xz2G4rxaQuGZRb1e7Blc0cEXHgOLyHF3Z+3LN7mGR2bqmoLPYZ0tZxdkA7pZ2qI91Wk
	rwCdmbvM+XgNk7kJQxMcQ5zmg4YqU5hxWcH6ZZA==
X-Gm-Gg: ASbGncsY0au93ZUGM+sPNy3Ru/akdcPGe+jLFEfVDKEAcTJ4t2hFE6y/NfQ0yjl2l6s
	DvpFLpwYVcck+ltrs6KFakvFAmxgKH97QppreX6ij9E+lQiZEJ2Rzz8Ba8r/4rT0ozs0cWQ==
X-Google-Smtp-Source: AGHT+IF6Aq3kCV5nQTRjMtE2g7qeZhfmB29CDO0rGpt/gIBQlQD2A9G5LdwdXL9dLc5a3JPMnZZg2x3hrL4+vC0eBx0=
X-Received: by 2002:a05:6808:1b07:b0:3eb:551c:b67b with SMTP id
 5614622812f47-3f3eb138ab6mr5848729b6e.38.1739792033820; Mon, 17 Feb 2025
 03:33:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250217-mptcp-dss-drop-mpj-v1-0-d671d6b9a153@kernel.org> <20250217-mptcp-dss-drop-mpj-v1-1-d671d6b9a153@kernel.org>
In-Reply-To: <20250217-mptcp-dss-drop-mpj-v1-1-d671d6b9a153@kernel.org>
From: "Chester A. Unal" <chester.a.unal@xpedite-tech.com>
Date: Mon, 17 Feb 2025 11:33:42 +0000
X-Gm-Features: AWEUYZl-JOjfbDjzzoi_v6oiXL0MJxoKBhmbJHKkBRGCey7eTOGdrGeoiIgxXD4
Message-ID: <CAD501OvWQg5Tvg33fPOzQCLSX4twd3=2-H1Zj0iwwfpSNfzmxw@mail.gmail.com>
Subject: Re: [PATCH mptcp-net 1/3] mptcp: reset when MPTCP opts are dropped
 after join
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Zenon van Deventer <zenon@xpedite-tech.com>, 
	Alexander Scholten <alexander.scholten@xpedite-tech.com>, 
	dwayne Du Preez <dwayne.dupreez@xpedite-tech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested-by: Chester A. Unal <chester.a.unal@xpedite-tech.com>

Thanks a lot!
Chester A.

On Mon, Feb 17, 2025 at 8:38=E2=80=AFAM Matthieu Baerts (NGI0)
<matttbe@kernel.org> wrote:
>
> Before this patch, if the checksum was not used, the subflow was only
> reset if map_data_len was !=3D 0. If there were no MPTCP options or an
> invalid mapping, map_data_len was not set to the data len, and then the
> subflow was not reset as it should have been, leaving the MPTCP
> connection in a wrong fallback mode.
>
> This map_data_len condition has been introduced to handle the reception
> of the infinite mapping. So instead, a new dedicated mapping error is
> now returned (infinite), and this special case is properly handled: the
> exception is only applied to this case now, and not other ones by
> mistake.
>
> While at it, no need to set map_data_len to 0 as it will be set to
> skb->len just after, at the end of subflow_check_data_avail().
>
> Fixes: f8d4bcacff3b ("mptcp: infinite mapping receiving")
> Reported-by: Chester A. Unal <chester.a.unal@xpedite-tech.com>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/544
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  net/mptcp/subflow.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index d2caffa56bdd98f5fd9ef07fdcb3610ea186b848..6ec03580ccec12fb50fc3aacf=
3d22413647b32b5 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -969,6 +969,7 @@ enum mapping_status {
>         MAPPING_DATA_FIN,
>         MAPPING_DUMMY,
>         MAPPING_BAD_CSUM,
> +       MAPPING_INFINITE,
>         MAPPING_NODSS
>  };
>
> @@ -1139,8 +1140,7 @@ static enum mapping_status get_mapping_status(struc=
t sock *ssk,
>         if (data_len =3D=3D 0) {
>                 pr_debug("infinite mapping received\n");
>                 MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPRX);
> -               subflow->map_data_len =3D 0;
> -               return MAPPING_INVALID;
> +               return MAPPING_INFINITE;
>         }
>
>         if (mpext->data_fin =3D=3D 1) {
> @@ -1357,7 +1357,8 @@ static bool subflow_check_data_avail(struct sock *s=
sk)
>                 status =3D get_mapping_status(ssk, msk);
>                 trace_subflow_check_data_avail(status, skb_peek(&ssk->sk_=
receive_queue));
>                 if (unlikely(status =3D=3D MAPPING_INVALID || status =3D=
=3D MAPPING_DUMMY ||
> -                            status =3D=3D MAPPING_BAD_CSUM || status =3D=
=3D MAPPING_NODSS))
> +                            status =3D=3D MAPPING_BAD_CSUM || status =3D=
=3D MAPPING_INFINITE ||
> +                            status =3D=3D MAPPING_NODSS))
>                         goto fallback;
>
>                 if (status !=3D MAPPING_OK)
> @@ -1405,7 +1406,7 @@ static bool subflow_check_data_avail(struct sock *s=
sk)
>                         return true;
>                 }
>
> -               if (!subflow_can_fallback(subflow) && subflow->map_data_l=
en) {
> +               if (!subflow_can_fallback(subflow) && status !=3D MAPPING=
_INFINITE) {
>                         /* fatal protocol error, close the socket.
>                          * subflow_error_report() will introduce the appr=
opriate barriers
>                          */
>
> --
> 2.47.1
>
