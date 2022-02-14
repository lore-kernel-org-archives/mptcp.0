Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EADDC8A
	for <mptcp@lists.linux.dev>; Mon, 14 Feb 2022 20:41:54 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id z16so9368015pfh.3
        for <mptcp@lists.linux.dev>; Mon, 14 Feb 2022 12:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=F5Bcu3AQialbtjyjcVbLDjwCDX6fgioPYZncNHqCu0k=;
        b=ZTNP/noDbnb3b8pwbfGJXx3MzBoYR74oY6CXZii9fO7aptoghYf+PZPcAx9A03Yku+
         bshdlHTB29Nhf3ifDMWFazc94NcYpUpXOs/k9QgjYxciqwGyu+Q53q/JqMkTZ817HUxe
         8+Ub2ypGWC3XZrrUA9byE/1Cmq/LP5peJp0rEWqUQAhJg5GhixWg6lqGXcTumxGe/w2m
         5uj7yqriaXRZ6H1PX8M4WC51YMP1VHe1f1BBBFl+ZTSqUC00udW6Sn0xgIMDxD58b3KE
         bf2bpLFUavYxSoiGGa4cf8pmUDZW71GKUUtDVyxfS5lXgrqQOmoV/p5QHuTlZzpyz6f4
         uTEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=F5Bcu3AQialbtjyjcVbLDjwCDX6fgioPYZncNHqCu0k=;
        b=s1nBL+W7oZgg63Mldy/M5NcVIDxEyCWq2NP8Onbu6TaDNy3WzJ078NBhmMIH5zQIE8
         U9h8u7B68g0In2o3n/+CdZiLjewEUQtCdQ371MWFhK7u6bGYn3VivA7bS9vDGIZKAnue
         9eB77IDmhImSF7hJdiRvjOW/Hp1OZDjgd1dyWA88f7oKjlAWPa1OP1CxaJF+G3tbjbcf
         bwf52YbVVJExk7GmAFZDani8hysAPvYkp3VpZXyfrKXd2TTaqOhJc/cKEQRDqWtD5+UO
         K9Zmp1gnWba7Yip2/UusYfskKYDzKN/fDvKDAFp0U11+tUpqbpaUufhbrvyjJ0df5wjC
         aroA==
X-Gm-Message-State: AOAM530Qk2wj6kxGuiR6qn+plx9bXUXsYFb2HWWl6+LbnRkx08afVNvn
	fvdEzsNQsb9n2xz1iat5Xg==
X-Google-Smtp-Source: ABdhPJw3KcHiyzx19l9C12LMnfV2rNnaCQpKYOPrAOQw7DB/Lvji0Eu5rm23ja+RHZGf33ZwPoaexQ==
X-Received: by 2002:a65:6e04:: with SMTP id bd4mr648396pgb.375.1644871313778;
        Mon, 14 Feb 2022 12:41:53 -0800 (PST)
Received: from [127.0.0.1] ([20.69.179.156])
        by smtp.gmail.com with ESMTPSA id a37sm402996pga.3.2022.02.14.12.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 12:41:53 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: SelvaKumar S <selvakuma.s1@samsung.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220214080002.18381-11-nj.shetty@samsung.com>
References: <20220214080002.18381-11-nj.shetty@samsung.com>
Subject: Re: dm kcopyd: use copy offload support: Build Failure
Message-ID: <ac316612-dd4d-3a1a-454c-d94d58dc421a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Feb 2022 20:41:53 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi SelvaKumar,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://patchwork.kernel.=
org/project/mptcp/patch/20220214080002.18381-11-nj.shetty@samsung.com/
  https://github.com/multipath-tcp/mptcp_net-next/actions/runs/1843130390

Status: failure
Initiator: MPTCPimporter
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/84deecc163f6

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
