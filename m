Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E882B210B
	for <mptcp@lists.linux.dev>; Tue, 31 May 2022 09:24:42 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id j21so12270635pga.13
        for <mptcp@lists.linux.dev>; Tue, 31 May 2022 02:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xeucAChSDh+7yh3jLWhSG0ySXy+Y7ULvnWp+zI9w/5c=;
        b=jI8n5ZN8azH372qn8gFCTTXewE5S/ExZ65dqwu2BvHemHen8VPu6cwTnglOMvTDxYd
         44D7PuefzCNe8InLoZ6X/AChYDc/357eP7rKGUR4ZZtEorluUlbxFLv6DJ2E0fglAefc
         tdxF3WOHjpH1HNIVRGWQiaozi2vCiNkK2Rc9gPAKY+/HHl8+uLYRXvlo3J5r4W134f0U
         4atu0cbyWLUyGT46hqTdZd83gtzy2pVCaqn+4oJ/iXL0Fwe1Bi6JOvyiSBQlU9VBQiMZ
         D1dzMcWCQ0XaVw/6the0CQJqqzIa7e4i4EVG6A9ofF7eKNQiuOyw7dj7lNGJg4fXPWYx
         cudA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xeucAChSDh+7yh3jLWhSG0ySXy+Y7ULvnWp+zI9w/5c=;
        b=s5aWp4bw8si9dErmIrpDzTVzuiE5fv/MQwhpSgYeZNEaHx7z2tQWbvlz0WuUnb58XP
         +Xf0A4p3l2pTMm2/K53spf9EScvUAP5XZW4zzojMttqZYAk1izBY/f1lVLv7MStef5qB
         9yLUQsgGa408Ozozio1FK5yNuJu5q7h0dLEJ0490sv0ngKQzkteUqMgLhpGxeHXJs4AL
         dDsYrIhyQg8mL6Qkw9zSTeKBnT2mutB2HFhZYzTxV2Z63cY5gJwhweF+xYsyldjeabl+
         dKiV1LagYx3VVzlmm3MMLw3IjT3wOAGUmih93CK6cAbuFaIoCe/hHZCZfK4kfH5PmMe7
         BsvQ==
X-Gm-Message-State: AOAM5331x+h5V+zcrl89Id0UcpHYOQNfsXzrCfGU8uq7C/CR5+M33YqF
	UxLtjeOdDuYIYle+TTSifTP+8vmwyPRQ0+a1VTdJeT1NOyo=
X-Google-Smtp-Source: ABdhPJyfXW8PlYY+Oi++VWFHo3ki8T+h09n1zAMn7IVUiNvPKCNIczHa5a10WNI2VFoSTsMNliYnllonbnFoZ/8Bpvc=
X-Received: by 2002:a63:2:0:b0:3f6:5b37:e94c with SMTP id 2-20020a630002000000b003f65b37e94cmr47958835pga.356.1653989082416;
 Tue, 31 May 2022 02:24:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1653987929.git.geliang.tang@suse.com> <9037c9679144745dde14866e1f975d221df90f94.1653987929.git.geliang.tang@suse.com>
In-Reply-To: <9037c9679144745dde14866e1f975d221df90f94.1653987929.git.geliang.tang@suse.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Tue, 31 May 2022 17:24:50 +0800
Message-ID: <CA+WQbwu1cuc4fOnqwFM39uE4W6RxaLZNkmYV_ye5g_OaHjvR9A@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v4 08/10] selftests/bpf: add bpf_backup test
To: Geliang Tang <geliang.tang@suse.com>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

The subject should be update to "selftests/bpf: add bpf_bkup test".
