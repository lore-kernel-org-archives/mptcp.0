Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D83813D630
	for <mptcp@lists.linux.dev>; Tue, 16 Jul 2024 10:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721127399; cv=none; b=ezPqyiccBS+XjjJvfCK+tSfAcFP90ziaYOqITOQruH9f5iFy/7m+h1jWXsO16bT/jwHiX17YUEh5nVQ8yU3VlVBa6WH5mlolRcwqVYmmdY/QP/wVgPdTCIGPpmciAUs7Iyaas8gyprqS9kjpbmUio5YZR1nvt0+S+bhV4ZwOcJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721127399; c=relaxed/simple;
	bh=LGBt1UcpVz575s2o3qxKHZocDtTIet6sPrSfPUVQMKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LMMdc7mSzh4f7Lz48Pf49RXi5j3e8XzPKlSnaMbIaRxaMfXY0EnD1RBXdijS/cht9NxWR/m/K59HYgVV7GXfdrhvGV5GexObz36IHbQ6GhFsOCvxFIJpp+1XqQOT9mKgE2/HIBL6q8wmbRF7IMARkYE2qJLWeP+fB2ZnJQvrHXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K5XiJjac; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K5XiJjac"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87D8CC116B1;
	Tue, 16 Jul 2024 10:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721127399;
	bh=LGBt1UcpVz575s2o3qxKHZocDtTIet6sPrSfPUVQMKI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=K5XiJjacjGtpIchDIkidz5rawUAwF2laj+hNueL3wBAKigN4f7Mqx+GKsNqEeveRA
	 uMmoPjib8mjLT3lzGbnVdSpKa+5VoRwIASc18fi8DDZVpXp+paX5T70z0Sb/8v8gyX
	 y2BH/mOeacupWKAxSw6UXEa8FIzM/HildxAH2/14oaOeyr0jVDJ3zX1p/0KJ5FCxsV
	 h789CHD2RM5GOK9EENQfDu7QslwXcDjKrwAJp9Va9kLu/PJfOumhdLOf6G2YiFw0FB
	 friey4WdvOMCtjVVaaMV8eco1L9sRSoRAFFOqGz0YabG5zeN9hU7lus2OcC+bQBaSg
	 QL79lwensy84Q==
Message-ID: <12f970d0-26c1-4426-9651-78412394c09b@kernel.org>
Date: Tue, 16 Jul 2024 12:56:36 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net 4/6] mptcp: pm: fix backup support in signal
 endpoints
Content-Language: en-GB
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
References: <20240711-mptcp-backup-mpj-v1-0-d45506182a9e@kernel.org>
 <20240711-mptcp-backup-mpj-v1-4-d45506182a9e@kernel.org>
 <3b39df84-53c6-3d78-ccb1-6737955d29bf@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <3b39df84-53c6-3d78-ccb1-6737955d29bf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

Thank you for your review!

On 16/07/2024 07:48, Mat Martineau wrote:
> On Thu, 11 Jul 2024, Matthieu Baerts (NGI0) wrote:
> 
>> There was a support for signal endpoints, but only when the endpoint's
>> flag was changed during a connection. If an endpoint with the signal and
>> backup was already present, the MP_JOIN reply was not containing the
>> backup flag as expected.
>>
>> That's confusing to have this inconsistent behaviour. On the other hand,
>> the infrastructure to set the backup flag in the SYN + ACK + MP_JOIN was
>> already there, it was just never set before. Now when requesting the
>> local ID from the path-manager, the backup status is also requested.
>>
>> Note that when the userspace PM is used, the backup flag can be set if
>> the local address was already used before with a backup flag, e.g. if
>> the address was announced with the 'backup' flag, or a subflow was
>> created with the 'backup' flag.
>>
>> The MPTCP Join selftest has been modified to validate this case: the
>> test "single address, backup", is now validating the MPJ with a backup
>> flag. The previous version has been kept, but renamed to "single
>> address, switch to backup" to avoid confusions. The test "single address
>> with port, backup" is also now validating the MPJ with a backup flag,
>> which makes more sense.
>>
>> Fixes: 4596a2c1b7f5 ("mptcp: allow creating non-backup subflows")
>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/507
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>> net/mptcp/pm.c                                  |  9 ++++++---
>> net/mptcp/pm_netlink.c                          |  4 +++-
>> net/mptcp/pm_userspace.c                        |  6 ++++--
>> net/mptcp/protocol.h                            |  9 ++++++---
>> net/mptcp/subflow.c                             |  7 +++++--
>> tools/testing/selftests/net/mptcp/mptcp_join.sh | 19 ++++++++++++++++---
>> 6 files changed, 40 insertions(+), 14 deletions(-)
>>
>> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
>> index 55406720c607..98b0b31e3b8d 100644
>> --- a/net/mptcp/pm.c
>> +++ b/net/mptcp/pm.c
>> @@ -405,7 +405,8 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock
>> *msk, unsigned int remaining,
>>     return ret;
>> }
>>
>> -int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common
>> *skc)
>> +int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common
>> *skc,
>> +              bool *backup)
>> {
>>     struct mptcp_addr_info skc_local;
>>     struct mptcp_addr_info msk_local;
>> @@ -413,6 +414,8 @@ int mptcp_pm_get_local_id(struct mptcp_sock *msk,
>> struct sock_common *skc)
>>     if (WARN_ON_ONCE(!msk))
>>         return -1;
>>
>> +    *backup = false;
> 
> This will modify *backup on some error paths (but not the one that
> returned -1 above). While the code that calls this function will ignore
> that variable if this function returns an error anyway, I think it's
> worth it to only set *backup on success within this function, just
> before the 'return 0'.

Good point. I thought I had to add '*backup = false' in many places, but
no, only 3. I can do that then.

>> +
>>     /* The 0 ID mapping is defined by the first subflow, copied into
>> the msk
>>      * addr
>>      */

Note: when applying the modification above, I just realised I was not
supporting this case with the 0 local ID: if there is an MPJ from/to the
ID0. I can fix that.

>> @@ -422,8 +425,8 @@ int mptcp_pm_get_local_id(struct mptcp_sock *msk,
>> struct sock_common *skc)
>>         return 0;
>>
>>     if (mptcp_pm_is_userspace(msk))
>> -        return mptcp_userspace_pm_get_local_id(msk, &skc_local);
>> -    return mptcp_pm_nl_get_local_id(msk, &skc_local);
>> +        return mptcp_userspace_pm_get_local_id(msk, &skc_local, backup);
>> +    return mptcp_pm_nl_get_local_id(msk, &skc_local, backup);
>> }
>>
>> int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
>> unsigned int id,
>> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
>> index 7635fac91539..44bfab351693 100644
>> --- a/net/mptcp/pm_netlink.c
>> +++ b/net/mptcp/pm_netlink.c
>> @@ -1064,7 +1064,8 @@ static int
>> mptcp_pm_nl_create_listen_socket(struct sock *sk,
>>     return err;
>> }
>>
>> -int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct
>> mptcp_addr_info *skc)
>> +int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct
>> mptcp_addr_info *skc,
>> +                 bool *backup)
>> {
>>     struct mptcp_pm_addr_entry *entry;
>>     struct pm_nl_pernet *pernet;
>> @@ -1076,6 +1077,7 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock
>> *msk, struct mptcp_addr_info *skc
>>     list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
>>         if (mptcp_addresses_equal(&entry->addr, skc, entry->addr.port)) {
>>             ret = entry->addr.id;
>> +            *backup = !!(entry->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
>>             break;
>>         }
>>     }
>> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
>> index f0a4590506c6..adc015af168e 100644
>> --- a/net/mptcp/pm_userspace.c
>> +++ b/net/mptcp/pm_userspace.c
>> @@ -137,7 +137,7 @@ int
>> mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
>> }
>>
>> int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
>> -                    struct mptcp_addr_info *skc)
>> +                    struct mptcp_addr_info *skc, bool *backup)
>> {
>>     struct mptcp_pm_addr_entry *entry = NULL, *e, new_entry;
>>     __be16 msk_sport =  ((struct inet_sock *)
>> @@ -151,8 +151,10 @@ int mptcp_userspace_pm_get_local_id(struct
>> mptcp_sock *msk,
>>         }
>>     }
>>     spin_unlock_bh(&msk->pm.lock);
>> -    if (entry)
>> +    if (entry) {
>> +        *backup = !!(entry->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
>>         return entry->addr.id;
>> +    }
>>
> 
> *backup is left unchanged on the !entry code path, which could leave it
> uninitialized.

(it was not because it was initialised in mptcp_pm_get_local_id(),
before calling mptcp_userspace_pm_get_local_id() -- same in pm_netlink.c)

Cheers,
Matt

> 
> - Mat
> 
>>     memset(&new_entry, 0, sizeof(struct mptcp_pm_addr_entry));
>>     new_entry.addr = *skc;

(...)

>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/
>> testing/selftests/net/mptcp/mptcp_join.sh
>> index 55d84a1bde15..167914df05fa 100755
>> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh

I should probably split the modification of the tests, to ease the
backport (the backport of the test is optional if it is too hard to
backport).

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

