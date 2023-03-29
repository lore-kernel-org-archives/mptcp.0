Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9E4AFCD
	for <mptcp@lists.linux.dev>; Wed, 29 Mar 2023 08:55:44 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id m2so14848007wrh.6
        for <mptcp@lists.linux.dev>; Wed, 29 Mar 2023 01:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680080142;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yS+xd2Fob95zpd6Ty94CbjFha22UA6g/D0HuCwAkeus=;
        b=io6F6iru4PQ45X2oihRsKrMORme3c346LP1ASHdpqBCdEBKGREPLf20ujxtKSKTpJn
         cPgbmeFoSTU6qGM+OP7ZWKxgyP9YEEG5GSd2j5Pb6qPyWZSKk79I7kBVXVz1zi8sJ8/k
         cTNMFGkADDKILIVwNYhP0hCpW8WF12ka6Y8am7VEm1/1PSTrGwOrp5WxP9aX/+Mx1Ixa
         ozDlEmQth4tFOEWopg0J/1/IVxMWApB5dzO5JE9BpN/BwKv2dPTlBy5MvAB0vGD2qgdS
         BL+1bGoUVR1zEJXTUDLP26c8V016LhmjV3itQPdjSyqfyYtqtlmbPk5Dv2xzj4H6tXiH
         C1gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680080142;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yS+xd2Fob95zpd6Ty94CbjFha22UA6g/D0HuCwAkeus=;
        b=ZN2YR2opOFbFrcFZin7CtfT/cNjbX3NuJxJ5WQujy1AOElKwnMRxLqgBzQGs0+Lba6
         H4RuQwQ5wHXCKbxIuAw/8tC4Q9FO9dNOxEQJNgbDZSMZvrcjZesSKOsbMW3SJ+upkxcp
         OsNpuSXac/OF4I/CCt4XhX1dfmswZGJQd89XU2m8V8Vb7A5rHJ6AmHBN+0CcMuKGfyNV
         BI54yBPGINQjrsBNhJWr5Jxn+w/VpHvG3vsXWGfAiBaxBb3o4U1Iaf6LIddrdNuOe3tx
         EF4gjw8lJp8GenJmqyPYRfqVwM1MGij6uXRuXYh0A5wE81OmfEPrCY0SHnkTbqXCgnbA
         BAcA==
X-Gm-Message-State: AAQBX9ffXm9c5orAOl0Ic5VD/HCHB8HXr9/zxgJlFEV+5BebkwEVScHI
	cSin6he8kk9QU2TzJXk8NbQrUEK42Hz6vwu5uCavKhfKNAg=
X-Google-Smtp-Source: AKy350YCTneuVhYC/9Ij6p+kBTPSC2+c78Mzfo9dhJ62z48+w51RseXyMTvfNjuktLWiflZ6NV0BMSYlHYecp8X7wLQ=
X-Received: by 2002:a5d:58f8:0:b0:2c7:1320:7781 with SMTP id
 f24-20020a5d58f8000000b002c713207781mr3803750wrd.13.1680080142268; Wed, 29
 Mar 2023 01:55:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Iheb Zannina <iheb.zannina@gmail.com>
Date: Wed, 29 Mar 2023 10:55:31 +0200
Message-ID: <CAKdABxssnqVYwgJnhqD4653-n8+aCX1CCqNOxN-EWG+YWaGRyg@mail.gmail.com>
Subject: MPTCP_Up_Stream
To: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

I am working on MPTCPv1 schedulers in linux V5.15.
But I can't find the MPTCP scheduler in "
/proc/net/mptcp_net/rbs/schedulers " nor the
" /proc/net/mptcp_net/rbs/default " file.
Where should I find the schedulers files?

Regards
