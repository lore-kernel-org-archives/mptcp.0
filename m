Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129431852
	for <mptcp@lists.linux.dev>; Wed, 18 May 2022 06:33:24 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id ev18so1071975pjb.4
        for <mptcp@lists.linux.dev>; Tue, 17 May 2022 23:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kZETzapApXvoc+ZZGE3y32do3aXD1FGIwd1d+xHKBho=;
        b=P7G1E5TvR0xB36c4au+8b1pMIIUaAZI4XD5baspKwFdGPlhrEMGir8o5VEb1NHhubt
         WP1kGA5q92rPQEuaFv4QwqsK2wt0Ad+5R3ivBPoGwoD97RaZFEaEYCMk8qzHgZKMA3E6
         ZpoVOsn4DGei6a9bhJvFPA2MJu/QwQu4DQltIGNdINkgT2Xa7cPSQ5VoIMFWvmWUNjRC
         22e65tN4UpQ/qaOjHPfbyLBd49qUoh9bOuFzhO1IrMeJv7B3ZpDsEeanHSyW5FDMWMjL
         Qk9mdW0nHQ14ER10VdRc4yPtDy5P230U2QI2iiNMWf6GSMBeuidGk72OH9WjWkegdMbA
         dzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kZETzapApXvoc+ZZGE3y32do3aXD1FGIwd1d+xHKBho=;
        b=5qXTFAUhkbqMw5Scnq3iLtqpT6dbWSxlO2I+7NSh2pGpFRbrjHPK1CigSdtU47hWjg
         PUcfaX3rF36mIg+r82vi35PhbiS31jX7Yh/0bjXn0JAlVlppd6K1hNK9HUGq8dtFC34t
         8H2VfUTXYEk+jCxRzKyWJIYXsx9KzIDt24Suk5LsNk+/3DCz3TsBVNw9gPqmiyaNXNKa
         uxq05chgvHRc0Ib5IoiTxSFLGRtoaCmS+cGdUw+C/oJbnPx0FBc5GRJirxB88gUkeelC
         azs9Cfi4LRH1RPu4yw+0uS5O8d+0KNDjCMytJW1Wgpew96g5I3C6jxmtoZYJfQ6ztUGK
         yDWA==
X-Gm-Message-State: AOAM530N64Y1zHfWC3GNpsLWl+r/0ihdbgKopoONtqSXnA91P7t4vLZ3
	kGY7H42fCjeP7Fs9VxyqiqM0AaUeuGLD7zb+NFc=
X-Google-Smtp-Source: ABdhPJyxS90d8ZeOxtBhmMKcLUNlsq04P0UATUeFCGuAL7mi1TuwRE7n0OhILWOoHGEByB7baCBAFTdKC6Yn5KP+ptU=
X-Received: by 2002:a17:90b:4b4b:b0:1dc:8724:3f75 with SMTP id
 mi11-20020a17090b4b4b00b001dc87243f75mr39793464pjb.178.1652855603502; Tue, 17
 May 2022 23:33:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1652853898.git.geliang.tang@suse.com> <b77ecd506fbc88292a699905b5cb9b27dad65f6d.1652853898.git.geliang.tang@suse.com>
In-Reply-To: <b77ecd506fbc88292a699905b5cb9b27dad65f6d.1652853898.git.geliang.tang@suse.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Wed, 18 May 2022 14:33:26 +0800
Message-ID: <CA+WQbwtf-EqvtVa0zBGJ0fFv8jNE0suOXcCb9v5W-aCLAbxL0g@mail.gmail.com>
Subject: Re: [PATCH mptcp-next 08/17] selftests/bpf: verify token of struct mptcp_sock
To: Geliang Tang <geliang.tang@suse.com>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, Matthieu Baerts <matthieu.baerts@tessares.net>, 
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

> This patch verifies the struct member token of struct mptcp_sock. Add a
> new function get_msk_token() to parse the msk token from the output of
> the command 'ip mptcp monitor', and verify it in verify_msk().

Please update the commit log:

'''
This patch verifies the struct member token of struct mptcp_sock. Add a
new member token in struct mptcp_storage to store the token value of the
msk socket got by bpf_skc_to_mptcp_sock(). Trace the kernel function
mptcp_pm_new_connection() by using bpf fentry prog to obtain the msk token
and save it in a global bpf variable. Pass the variable to verify_msk() to
verify it with the token saved in socket_storage_map.
'''
