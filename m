Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BBA671A
	for <mptcp@lists.linux.dev>; Tue,  6 Sep 2022 16:26:57 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id cu2so24646427ejb.0
        for <mptcp@lists.linux.dev>; Tue, 06 Sep 2022 09:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date;
        bh=0HttWAFBTjr6pSn89zHPcMqWfYLtcVX1sFnLl6PEMLk=;
        b=kz57SyVpaPJxGHKKaiFeyShzfr6kQUaWEklEoNiv7MjmnhdNZRhgJHF9vgYr9E1DF3
         wOQy1SOX0zyqpcjdNpKfK1pSStUuDXWQhAWipNABMCQyBrZNnwCNk+f65Tf9CnaOhXvK
         zm8k/Kylv0EFiXBdYxWbQ6cLr6sq7Lv+XeeFYyJgrnAbmMGH2q18dQ/tTU9mCKvGoA6d
         WmQo47bg4IcukUstlFcUCFrxBFaquTFzc+2JYJXHkleFx+/lis1wZs0Euh1SDQeNrB9J
         gfLLAGBkCDEnQdME/MBdVBoBSNqJQPlO/yPK7lY1wl+fh/kSQBuEfH+AcPmxmrXg+cTo
         ovCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=0HttWAFBTjr6pSn89zHPcMqWfYLtcVX1sFnLl6PEMLk=;
        b=GFcwHWyoFkV0IlE055sG1v2Hwq9a1e0Rir7piOSmQ40D2Zp8j31w79dtQ9SyS6q2NR
         WoTZgU6DXh+uiiDvS8+ltDgLh0vblNPBgkuo6s4vc7U6J08U7jqM/YnQ9Cv3aMqqACd4
         4z+YwcTpHLkaeVCzD3rR2oQ0BXgHVBlcwNabRrGCd8dusN/Hlb1X3fZdLKgFZ5E2ya6U
         HrEZpLEvfdekmFDMrafOE/BGLAZgPoKF1ZhKCC+yUWR1QWzTQvboZwZlP5Xt+mc8CW21
         739cwi2zhRBl5HTsh3kI8lObWDsxbk1m3mdB3UTfCBD+w5tCGDKhD5rxVk3/r83cpgrv
         ggdA==
X-Gm-Message-State: ACgBeo3jy6+ZQxuALD956TfetsHPC9eT5Zd45nqDar6ZTBE0vqdDzI6V
	WecHy20PjlqABrTQtRaNp+TDu/nsoUbGIuEZ
X-Google-Smtp-Source: AA6agR430jD6H2kJBEdYA5DpzpRTxsab4q8KDTqUy18QgvTZKVBLbaLyHpbadVBECP8aFkMmXGKIuw==
X-Received: by 2002:a17:907:94c7:b0:730:d5bc:14c with SMTP id dn7-20020a17090794c700b00730d5bc014cmr41194235ejc.68.1662481615852;
        Tue, 06 Sep 2022 09:26:55 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:6615:6f8d:478f:a6fc? ([2a02:578:8593:1200:6615:6f8d:478f:a6fc])
        by smtp.gmail.com with ESMTPSA id s6-20020aa7c546000000b00448cb764290sm4225771edr.92.2022.09.06.09.26.54
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 09:26:54 -0700 (PDT)
Message-ID: <6f2b6d1d-7c7c-0c80-85ee-fc35ace59f50@tessares.net>
Date: Tue, 6 Sep 2022 18:26:52 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH mptcp-net] Documentation: mptcp: fix pm_type formatting
To: MPTCP Upstream <mptcp@lists.linux.dev>
References: <20220906122025.743592-1-matthieu.baerts@tessares.net>
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20220906122025.743592-1-matthieu.baerts@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 06/09/2022 14:20, Matthieu Baerts wrote:
> When looking at the rendered HTML version, we can see 'pm_type' is not
> displayed with a bold font:
> 
>   https://docs.kernel.org/5.19/networking/mptcp-sysctl.html
> 
> The empty line under 'pm_type' is then removed to have the same style as
> the others.
> 
> Fixes: 6bb63ccc25d4 ("mptcp: Add a per-namespace sysctl to set the default path manager type")
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>

I just applied this patch in our tree (fix for -net):

New patches for t/upstream-net:
- 8fe9543c0acd: Documentation: mptcp: fix pm_type formatting
- Results: 9a90302f0e94..6cfce7e8a42a (export-net)

New patches for t/upstream:
- 8fe9543c0acd: Documentation: mptcp: fix pm_type formatting
- Results: cc17a6220548..7191ca91a85d (export)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
