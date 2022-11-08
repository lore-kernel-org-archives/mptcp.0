Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB85B8F44
	for <mptcp@lists.linux.dev>; Tue,  8 Nov 2022 09:34:14 +0000 (UTC)
Received: by mail-il1-f181.google.com with SMTP id z9so7195056ilu.10
        for <mptcp@lists.linux.dev>; Tue, 08 Nov 2022 01:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hRLrr2OnBk/jsYl44myxEnsCEbmZGyhBkur4YTi7aTk=;
        b=It4GX3+sziaYL6LoUudrcVV6UWcW+dvhtFO1V15nBcMbaVeKONa9ETuQ9tFU5add+f
         M0gNYTIzdSPCkbeeNktGKovxQL/X/4yI2Gym+ojpy4eufl8+QoNHa9/wQhLPYd/6yZHT
         SFhgEw9aKVtNM6CZt5knOD/XVFOUpD/xMKai0QmgPdQupRiCykTcsVavBWtA9Bb6JCbp
         2p8NDhr1RxKI7N8JVxAs/pPKkZCp2lvfYGwcRpRvux5QSSxzav0iMteEu4rJMr8wmG6c
         vlr4pIwP2Z/DSpDzK+Rh2T9JaYHDVJ5PJEzRWFRaugPCpG6SdMYMAJn4KKfMGhJpa/Tt
         hOaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hRLrr2OnBk/jsYl44myxEnsCEbmZGyhBkur4YTi7aTk=;
        b=ALUQZgBc0p4F29U5BsLNE4J9UXM5K3hsmP0WXNL70dMD/uO/xAbAWzONktpRs1zerw
         TTF4epftSPOXhwIkeNy/1SiHGT3S4daTma6DNlGHiSAThtTIunZ3IIUvY5bQxsQQg5Za
         Il5mez2pOS2voyFgvoRp6L0QLCsYiib77NR3IMfYKF3VOFDqfWh1wozWw+zghcwT3obL
         uJcX0H/vG/NvBtgbawt67V0kErMQjwJUaQ75891JqCXiOt84IeAe9jLk/AXnUiNpinjO
         VcZgRuALJ2rxTr2tMvEIv4zureAvHUwjWQADZeKS/AFy6kfCJvKQtQudyrvq6Q2uR5ur
         cE7A==
X-Gm-Message-State: ACrzQf2eCghFEWYtv6RWAQ3lgQc6iYX6SQZBRTw99NmQ5f92s0jtmNz1
	PjBpxYNkMIux8BlU6J6OJNq360b+cFUQ
X-Google-Smtp-Source: AMsMyM5gWsCHJRyZnrD8MLjFtaB10N8kQ1Ik+oUkd6BeL/xcGUI3PRSqO0PSpP24AFaiybpe+z91mw==
X-Received: by 2002:a92:d243:0:b0:2ff:c2cd:ed61 with SMTP id v3-20020a92d243000000b002ffc2cded61mr30860595ilg.287.1667900053995;
        Tue, 08 Nov 2022 01:34:13 -0800 (PST)
Received: from [127.0.0.1] ([40.122.235.232])
        by smtp.gmail.com with ESMTPSA id d1-20020a056e02214100b002faf6559e90sm3695155ilv.51.2022.11.08.01.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 01:34:13 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <92d945d60c7a97d26d30a7dd8dff441b5509968b.1667897099.git.geliang.tang@suse.com>
References:
 <92d945d60c7a97d26d30a7dd8dff441b5509968b.1667897099.git.geliang.tang@suse.com>
Subject: Re: selftests/bpf: Add bpf_red test: Build Failure
Message-ID: <14be105e-3f9a-88c0-6fe3-e5e27ea4a64f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Nov 2022 09:34:12 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://patchwork.kernel.=
org/project/mptcp/patch/92d945d60c7a97d26d30a7dd8dff441b5509968b.1667897099=
.git.geliang.tang@suse.com/
  https://github.com/multipath-tcp/mptcp_net-ne=
xt/actions/runs/3417962790

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/e24daa06c1=
1e

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
