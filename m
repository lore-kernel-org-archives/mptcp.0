Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5FA1799A
	for <mptcp@lists.linux.dev>; Tue, 19 Dec 2023 11:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X39DGrIR"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-35fb42a07f1so6976585ab.0
        for <mptcp@lists.linux.dev>; Tue, 19 Dec 2023 03:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702984066; x=1703588866; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ByEpnbQNFVyQSPj8Jl0lZJqX3Soq+JIkQIWq1G7KxDE=;
        b=X39DGrIRZcwwR4BJg7L6Ml49GkVoA1CmHHAzWBzPT+5fB5cmroo6fzkgEKRXWqe2vM
         onV9Ztv7fxvdoc6Nf5CMYOcC73KvIy4/xtFVs15pUJnuOs5APk0R+0I57xzsg/gk2oAN
         z9nClS+RCPLoVIje+LTTyTrQkJe6lvEYN3frH/1yQ343fU2QZMDXTz3M5JaO3bO9TcKS
         k9U93gOoQ7XdafppO6oZwN3Fcq/Rw83ZQiKb88HUReQL66Xc7d3bgzUcey3SvQSLYvSy
         o/hvLfLPnLA3idORir3rv/Ezc1lH7ftnQypL7WTcA8DgLdQMiEPwRkx2OcojzWdUSNjf
         O/ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702984066; x=1703588866;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ByEpnbQNFVyQSPj8Jl0lZJqX3Soq+JIkQIWq1G7KxDE=;
        b=FS+l2qXLN1E8PxFjID5jb4q4gb++p+RadD392ixj1xjrO9CezwTv/wqHe/xBEYC0pm
         cwBUzTzOwMnsM+c6kJccAvdKK8J0t8KaYUiRWcGhFoi9UsENPLdb9rHWBSlAt887KZ+Z
         l/NhTI3GWOonBFCC8BDgmUs3WVuNcRhkxmjCO8XxfsRNInDH3G5ZLxBxC0cyUFUKgUg5
         2RWBPlVBQdUdiAsCPQ4KULhNg3cKr7YDcHdUn8hcvzVduMWuNRv1/B3qF5aAyBiKW+hy
         BqznGoZdGyiIPZ5Ld0A0I6+sO4G8Exe6jSPgdmeTbIdaPFftv1l+zXmOf0s89on5KEla
         5Xfw==
X-Gm-Message-State: AOJu0YzvCncP5vaEqHkPGcRVgjlskJ6RsvA72N50VpGC5t8ZWsyEPtMQ
	xKjMu9/S4eNfWltcUeDdNA==
X-Google-Smtp-Source: AGHT+IEnoUbCzylAUYfMafzskOg7h0oQkSItQ14AfojbX4rYNc/KovaHsYWJLJe+BKlgLYeg6RncRQ==
X-Received: by 2002:a05:6e02:1cae:b0:35d:5d42:ba2b with SMTP id x14-20020a056e021cae00b0035d5d42ba2bmr22402184ill.8.1702984066628;
        Tue, 19 Dec 2023 03:07:46 -0800 (PST)
Received: from [127.0.0.1] ([52.159.137.233])
        by smtp.gmail.com with ESMTPSA id c11-20020a630d0b000000b005c2185be2basm19191168pgl.54.2023.12.19.03.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 03:07:46 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@linux.dev>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <9a8034c76311d8871fb8d9e69aefc459b2e607ec.1702973751.git.geliang.tang@linux.dev>
References:
 <9a8034c76311d8871fb8d9e69aefc459b2e607ec.1702973751.git.geliang.tang@linux.dev>
Subject: Re: selftests: mptcp: userspace pm get addr tests: Build Failure
Message-ID: <d840fc7f-e78d-2718-c9ff-74b8551ae7d3@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 Dec 2023 11:07:45 +0000
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
org/project/mptcp/patch/9a8034c76311d8871fb8d9e69aefc459b2e607ec.1702973751=
.git.geliang.tang@linux.dev/
  https://github.com/multipath-tcp/mptcp_net-n=
ext/actions/runs/7260823965

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/8745a4886c=
7f

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
