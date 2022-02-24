Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6337A
	for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 14:41:35 +0000 (UTC)
Received: by mail-ed1-f52.google.com with SMTP id bq11so3185741edb.2
        for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 06:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=UCb4afNpOF92qzdRO8QVC6HoxEssA9VLkZFW3gD8SaY=;
        b=o1w8MNlmXXGOkDmBT+saBHTcCC8MZyae5rvylrKYEeMd8Df7amgSu1m+2Nns8Q+12O
         qn+8W4BSbebNmVW6BFIDPeo38Q3iX2r64zfUOpCTxrzm+wHRJj/IpoiSM1gZd2Lu6yaN
         1e1KKDke5HDDhb2SSlcniWHi/QHQSOSjEjQFVV1BmtiYQOkggWuQjYv6KTlp+VPLfCsq
         FtdHADD40Y1BoToNbxizsmgQlUmZ0kj30h6mFea4VZIXF8uDQa1AERL9NkKhAiX2oKbU
         /LNug4rskP1R3mV7349HI63ZAFZR+76XhcNqmpgf6BtlStM3uzU+/ychT+j+kT2o2QCA
         rFJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UCb4afNpOF92qzdRO8QVC6HoxEssA9VLkZFW3gD8SaY=;
        b=m64fYIv0EvnhHqvlO4MnQGKjctO8Jt0tfULcalsfiy6rLJMEnhkORJBmnL58hakNLB
         PDXV1Qlf71nMy/dGdFJ0WxwonVkzICDDXdx5v+2Ry2zhQXQh8Mwit9QCtndGQZhVZr/H
         ni5mIviBvQqt9MnbQmE+klJQKtPkNYM16q1VFzveQbGVubWLKOf4j3sYHaG0vtim2fA8
         we77QdOdM4CUSEkmwbTp+9WTGLrSd2J27ZgUrTwAq8DZdzlI20qGdF4Bc6U1Eik0KZLv
         c3i/FTpcXqdOhIeRbqEhe9W70DCOH80042d64rt/n4CrARbWfxu9viqMxeHxu0qGsU1g
         er3g==
X-Gm-Message-State: AOAM531t/EkP7g/qYC9hPBC2rHjbEsqj88429DCR3GX6xgv6VQ/ljDfk
	7K5kHU53pnTkRI8fB2CN0vpDXsOI3C6Cvo2us58=
X-Google-Smtp-Source: ABdhPJxbm2UirVWE37fSPXXtq+6oHfeRSWaLWSGBFPrrDyJ9+U75HTxKSkCvuRDkZR0p2no1lQRQbw==
X-Received: by 2002:a05:6402:4315:b0:413:27b5:804c with SMTP id m21-20020a056402431500b0041327b5804cmr2575873edc.54.1645713693527;
        Thu, 24 Feb 2022 06:41:33 -0800 (PST)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id y22sm1445099ejm.225.2022.02.24.06.41.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 06:41:33 -0800 (PST)
Message-ID: <431c81f9-e858-46c0-a2d1-6b32445dee3d@tessares.net>
Date: Thu, 24 Feb 2022 15:41:32 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH mptcp-next 0/3] Upstreaming cleanup
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
References: <20220218221814.72026-1-mathew.j.martineau@linux.intel.com>
 <ec7dea0e-36cd-4a47-daf2-ae4e2cb20aa3@tessares.net>
 <7120fc8c-cb24-c54f-67fd-5aaa7d32f8b@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <7120fc8c-cb24-c54f-67fd-5aaa7d32f8b@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

On 24/02/2022 01:25, Mat Martineau wrote:
> On Sat, 19 Feb 2022, Matthieu Baerts wrote:
> 
>> Hi Mat,
>>
>> On 18/02/2022 23:18, Mat Martineau wrote:
>>> The most recent patch series I upstreamed for -net needed a couple of
>>> tweaks to mitigate net/net-next merge conflicts. The first two patches
>>> here update the commits in "fixes net" on the export branch to match
>>> what I sent upstream, and the third patch restores Paolo's function
>>> rename in mptcp_join.sh.
>>
>> Thank you for these patches!
>>
>> I was thinking a bit about how to avoid such "issues" in the future.
>> Here are some ideas:
>>
>> - there could be 2 separated trees periodically updated:
>>  - one for net-next, the one we have for the moment
>>  - one for -net: a new one
>>  → all patches for the -net tree would be duplicated in both trees
>>  → when applying patches in the -net tree, we will notice the conflicts
>>  → applying the different patches can be automated with the scripts I'm
>> currently using
>>
>> - there could be 2 mixed trees periodically updated:
>>
>>
>>            top
>>
>>             ^
>>             |
>>
>>    commits for net-next
>>
>>             ^
>>             |
>>
>>    merge net + net-next
>>
>>             ^
>>            / \
>>               \
>>    net-next    \
>>                 \
>>
>>                commits for -net (+ commits for the CI)
>>
>>                   ^
>>                   |
>>
>>                  net
>>
>>
>>  → no duplicated -net commits
>>  → the "export" branch will be on top of net and net-next
>>  → "mptcp: use kmalloc on kasan build" could be cherry-picked on top of
>> the "export" branch for the -net tree not to have it "under" the ones
>> for net-next.
>>
>> In both cases, it would be easy to export the different commits and have
>> different tags that can be used by the CI.
>>
>> The second case looks interesting to me but there are at least two main
>> points to be careful with:
>>
>> - if the "export" branch is on top of the net-next branch, it means the
>> patches we have in the tree might no longer apply as is in net-next:
>> that's the opposite situation as of today where the patches for -net are
>> on top of net-next. I think that's fine because we would have this issue
>> in any case if a patch for net-next depend on one that has been
>> queued/applied in -net but is not in net-next yet.
>>
> 
> I don't think it changes the situation for the mptcp-next patches - even
> today, they are on top of the mptcp-net patches which is what would
> potentially cause problems sending to net-next.
> 
> Since I apply the patches to net-next and resolve conflicts before
> sending to netdev, it's not too big of a concern. I think your proposal
> here is an improvement because fewer adjustments will be needed when
> sending the -net patches to netdev.
> 
> 
> I would adjust your diagram this way:
> 
> 
>            export
> 
>              ^
>              |
> 
>     kmalloc on ksan build
> 
>              ^
>              |
> 
>     commits for net-next
> 
>              ^
>              |
> 
>     merge net + net-next
> 
>              ^
>             / \        export-net
>                \      /
>     net-next    \    kmalloc on ksan build
>     (rebase      \  /
>      daily)
>                 commits for -net (+ commits for the CI)
> 
>                    ^
>                    |
> 
>                   net (rebase on upstream net-next sync,
>                        as you suggest below)
> 
> Then people could check out export-net when developing mptcp-net patches.

Yes, that's what I had in mind for the extra patches for the CI (for
KASAN, GitHub Actions and Cirrus).

> 
>> - there might be conflicts / build / validation issues from elsewhere
>> to resolve when merging net-next with -net: conflicts in non MPTCP
>> parts. They will have to be resolved before they are resolved in
>> net-next tree. Workaround is not update the "net" base in case of
>> conflicts until the sync is done by the -net maintainers: easy to put in
>> place in case of conflicts, a bit less for the build / validation issues
>> but that's probably rare. A lot of stuff are modified in the -net tree
>> with all the different protocols, drivers and BPF! It is not rare to
>> have conflicts if you look at:
>>
>>  $ git log --grep 'Merge
>> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net' net-next
>>
> 
> That sync-net-when-upstream-does workaround sounds good to me. I agree,
> it's not rare for those net/net-next conflicts to happen, and since we
> are carrying our own patches until the -net rebase anyway I think it all
> works out. 'git merge-base net/master net-next/master' gives the
> relevant -net commit.

Ah yes, that's a good idea to avoid having to manage various issues.

I was thinking doing that only in case of merge conflicts but this is
probably not needed.

> If we wanted advance warning, the CI could attempt a rebase of the
> mptcp-net commits on the current net/master (sort of a dry run) and
> notify if that had any conflicts.

Yes, we can also do some updates manually. We can also add an option for
the GH Action job to do that on requests.

>> What do you think?
>> First, do we need a solution?
> 
> It's not absolutely critical, but I think it's a worthwhile improvement.
> 
> This wouldn't prevent the net/net-next conflicts that I was asking about
> in this thread, since those were due to upstreaming some net-next
> patches before the conflicting -net patch was even available. Normally
> it will be better to prioritize the -net patches for upstreaming, and
> check for net-next conflicts while there are MPTCP patches in -net that
> haven't been synced yet. This kind of conflicting net-next patch can
> typically be delayed until the net/net-next sync.
> 
> 
> Even so, updating the export structure is worth it given that the -net
> patches are somewhat more sensitive (as we have less opportunity to
> correct problems before release). This makes placing the mptcp-net
> commits on top of the -net history a safer way to go.

That's right. And we can setup CI jobs when the future export-net branch
is modified!

>> Then would it be OK with the second solution, especially in case of
>> conflicts/build/validation issues? If not, would the first solution
>> helps? Or another one?
>>
> 
> I prefer the second solution (with the adjustments for the export-net
> branch). The way the first proposal maintains two versions of the
> mptcp-net patches would be harder to keep track of.

Indeed, if we have to modify a patch (not often but it happens), it will
not be nice.

I'm adding that to my TODO list!

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
