Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2EE71
	for <mptcp@lists.linux.dev>; Thu, 17 Jun 2021 13:28:12 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id u24so3977054edy.11
        for <mptcp@lists.linux.dev>; Thu, 17 Jun 2021 06:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=N9mgWXiALX7dj0POL9slXrEG7H3itFgApUkDPMdP9H0=;
        b=qkgwjAZrRbouZiDvksLC5j0QDCuoDSBpCTGz7jHyvsV6oCe+3++eKW89CmAWPzh+ER
         zku4NrjNRsABtb92gZ52jlxSv87OJN9uFDvePNFI/MmmFrsUVpXFULpAn6yM+roXlJEs
         X/wFJN7CSPmwoX0qlqHo0Yey/RVR/SJI9Dxg4m7lZLzXOuj/Hu6BJNq8Jy4mRPFLkrB6
         wHb0mBchblS9vbO8R4jakeXor9nIk296yBfuVDRH9uO/iB1MEbJkOPEx3ygW8bSuqE5a
         MpAY0YEvbWrA03vqC52/fzoE9zajfaOJ3kAXQN+TmpECexurPAj5DYy+Q+HwenLiiPFd
         3a4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N9mgWXiALX7dj0POL9slXrEG7H3itFgApUkDPMdP9H0=;
        b=FuI02jr6bxhzrnyL5KpLc0Vxqn/H/qafK86AegIvCncdOFwFgV9sr+lA2SE764BsUp
         onxD+/bZ612cBgHNfRlVCIn88V6KZL+blXyxTAT+bJZUHT2CqP6KO4Ul0vVT2mpAu+o6
         Ks4RysnyGlJyKtxudc8wrj5EkDvCwGWlUiulNK2s7AGuKxL6FkgzIK/KXhokXxLBBt14
         dAm45/xzd8pNBjgNTMgnyz0bnrCmE+VQTCSLgRj3RWYpfvF98zRkIuCQsBfrcYfWpJ9W
         pfALLaBRkwvmgLwW5gFOIfDzFHyjULZMGWBJ6Ex5V1M6FQfsuJSW6Ysf93lsPxYw7iVr
         SAeg==
X-Gm-Message-State: AOAM532N8keHA5UHCM5wSTwVcrix49bayR2F3tmUd3rC7v/jBUN6E4az
	G+EicQmmiYBm9OOkpSOo6D9oxDVROfRtOVPNWKY=
X-Google-Smtp-Source: ABdhPJxFTHzpJv9kZegpjYao3OaVVSgoZfMg7unb30lEQDN1YOs6p35yBxVZ1Zi0bBjr+pWW5qr0gQ==
X-Received: by 2002:a05:6402:27c9:: with SMTP id c9mr6595052ede.371.1623936490714;
        Thu, 17 Jun 2021 06:28:10 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:7d63:1645:b739:5196])
        by smtp.gmail.com with ESMTPSA id t17sm4531543edv.75.2021.06.17.06.28.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jun 2021 06:28:10 -0700 (PDT)
Subject: Re: [PATCH v3 mptcp-next] mptcp: refine mptcp_cleanup_rbuf
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <93432e2a93c4ae6124fb607346ecfac45d40b2b3.1623835767.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <24e5801e-c39e-6486-e41b-533234bb2a1c@tessares.net>
Date: Thu, 17 Jun 2021 15:28:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <93432e2a93c4ae6124fb607346ecfac45d40b2b3.1623835767.git.pabeni@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 16/06/2021 11:29, Paolo Abeni wrote:
> The current cleanup rbuf tries a bit too hard to avoid acquiring
> the subflow socket lock. We may end-up delaying the needed ack,
> or skip acking a blocked subflow.
> 
> Address the above extending the conditions used to trigger the cleanup
> to reflect more closely what TCP does and invoking tcp_cleanup_rbuf()
> on all the active subflows.
> 
> Note that we can't replicate the exact tests implemented in
> tcp_cleanup_rbuf(), as MPTCP lacks some of the required info - e.g.
> ping-pong mode.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Thank you for the patch and the review!

Now in our tree (feature for net-next) with Mat's RvB tag:

- 7c5442f3e2bf: mptcp: refine mptcp_cleanup_rbuf
- Results: 8db480094258..f40f6ff5a355

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210617T132720
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210617T132720

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
