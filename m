Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E2A3FC2
	for <mptcp@lists.linux.dev>; Tue, 31 Aug 2021 08:14:24 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id i21so36829101ejd.2
        for <mptcp@lists.linux.dev>; Tue, 31 Aug 2021 01:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:references:cc:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9xNzCNIb0b7Xe2yFIOwAzFUXPt3ZTXr6P+SdtwaqItg=;
        b=iA7Q1kavSganS/Snc2HeGDhK4uCWtXk81bNys2H5KBFK3Xla4P1A2a3eMuCvMTo2K4
         rXCVgMf81+p7lDmpUDvLFk7wb1l8BU/mPrZGowdP0UVKaQq5Iq9LtOYhjqIIY0WQ9r1R
         nEndUGs5PZCOnypPc3aVGQrSp9phIln5Laha+IARUVR2NvzQUwL3NxedCZgQGgnGYWWX
         39qujN936IIDrC9Sfr1RfHvhsfO8ISIaNprx9IgZFPSDI0ttvqJxW2Vu5dFI3S/Dre1E
         jRmfsUdR0KvprbaYSO+Vd0qDUFWnV1TCEHmVgW63Ia2cKrddQwIuw+qBYozx4vfBJBZm
         bw/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:references:cc:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9xNzCNIb0b7Xe2yFIOwAzFUXPt3ZTXr6P+SdtwaqItg=;
        b=Qrdpm4ddb/VBr5yXo6EyFO3JdTXU/+cxHOaC/Wt8h7OgoHNxB6BfVGBgEqAdEJ1fAP
         xdh7HkuiDTA1mPQqqVO+pXIi5lnB0YzrsUr6C3+OezVt9mP+kNorSoKA6ggUVH5I/grf
         3jr09hVruOKpc8T5o8PKzWH+KND23V/9hLl8Q4Czp6SIKpXzQXnukTgl+6qXzocwjiBY
         8Zy3djTrjgAe2LD/xA8+nZuul4t+BQjgrisGEFveF34zLw4kN32uydu/EuQl/hId71bj
         AHk9Gu+WO9fl4hzPpc0iFWUfyLv5NVscI8V3DF7P5h7dLsS5hP2LH7+I4/kKBjCtpXrE
         MHEQ==
X-Gm-Message-State: AOAM532mYba5uKFagXPP9eibVLXB3ROtIVih4lOrma/LVBcNE15CYnJi
	HnqLqo9ZNjwXUWlb6Vf01TSwSb7gpKKjd4PsQEc=
X-Google-Smtp-Source: ABdhPJwioe9u2bSJZSxkv3xoDc4zaAu7Sup2vkXAox2tTSGcBWBE6RLi1vRWyhMpDMJhUdgz4bU1oQ==
X-Received: by 2002:a17:906:2db1:: with SMTP id g17mr30124209eji.286.1630397662877;
        Tue, 31 Aug 2021 01:14:22 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net (94.105.103.227.dyn.edpnet.net. [94.105.103.227])
        by smtp.gmail.com with ESMTPSA id h19sm7841213ejt.46.2021.08.31.01.14.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Aug 2021 01:14:22 -0700 (PDT)
To: Paolo Abeni <pabeni@redhat.com>
References: <87b65514b5296bbf24b50d08b5289a977fa2a31e.1630395581.git.pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH net-next] Squash-to: "mptcp: fix possible divide by zero"
Message-ID: <f0572f75-37f0-b563-ee31-e8c0b8561962@tessares.net>
Date: Tue, 31 Aug 2021 10:14:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <87b65514b5296bbf24b50d08b5289a977fa2a31e.1630395581.git.pabeni@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi Paolo,

On 31/08/2021 09:40, Paolo Abeni wrote:
> To be appended to the commit message:
> 
> v1 -> v2:
>  - use lockdep_assert_held_once() - Jakub
>  - fix indentation - Jakub

Thank you for the patch!

- b09c5f12162d: "squashed" in "mptcp: fix possible divide by zero"
- f6abbc960435: tg:msg: update commit message after squash-to patch
- Results: f651c564fd29..54851c6a542b

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210831T081314
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210831T081314

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
