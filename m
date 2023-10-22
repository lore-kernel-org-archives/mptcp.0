Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318E363CE
	for <mptcp@lists.linux.dev>; Sun, 22 Oct 2023 23:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4+G7oBG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C883BC433C7;
	Sun, 22 Oct 2023 23:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698016576;
	bh=UknpXJtSC+2OBc/vb4SzcZX/ZPAnsQ+Wo3245yVh8Zs=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=n4+G7oBGnwh2gg2OeXUz83y768CVYOuPsyPAgbPERm4SLcJnTRbLeFgOzEMRxcE5k
	 EOyYbkVBjJ7w8xTHuL6UF3ji57BdndS6ZlmGUW01UOmpgmStacm65zjXa1WwDAykGq
	 GMPoNOZtKKlAu8eq2d5agH9sYbA6//TQHeBc0Wk8JkV1MITxEZq1OyQIj1QhsNoDk4
	 SDw/O6PyT6jqbpmL72em/5tWboBVTgxkcMskefcYFsLiY2MJhmiBbiODBvN9T8SqAJ
	 uG0lsWnmP3VCedq9rXe+rLph+qJy4hxNWyfQbF/U6awSq7dxfA9hBqzqehYB1w6IGh
	 bsqWQvrSHYOwQ==
Message-ID: <1f296a8e-f7cc-497d-9d36-6545e7c0a7a8@kernel.org>
Date: Mon, 23 Oct 2023 01:16:09 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v17 0/9] userspace pm remove id 0 subflow &
 address
Content-Language: en-GB, fr-BE
From: Matthieu Baerts <matttbe@kernel.org>
To: Geliang Tang <geliang.tang@linux.dev>, mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
References: <cover.1697511436.git.geliang.tang@suse.com>
 <de18b56a-4a05-4838-b9ca-081b00f7a225@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 Fe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI
In-Reply-To: <de18b56a-4a05-4838-b9ca-081b00f7a225@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 23/10/2023 01:06, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 17/10/2023 05:00, Geliang Tang wrote:
>> From: Geliang Tang <geliang.tang@suse.com>
>>
>> v17:
>>  - include "fix userspace pm CI failures" series.
>>  - update __mptcp_has_initial_subflow as Paolo suggested.
>>  - update chk_subflows_total.
>>  - update selftests.
> 
> Thank you for the new version, it looks good to me!
> 
> Reviewed-by: Matthieu Baerts <matttbe@kernel.org>
> 
> Now in our tree: a part in 'fixes for -net' and the rest in 'features
> for net-next' and this has caused conflicts, please see below:
> 
> New patches for t/upstream-net and t/upstream:
> - 20c92e1b1473: selftests: mptcp: run userspace pm tests slower
> - 54b8c59e976f: selftests: mptcp: fix wait_rm_addr/sf parameters
> - a9f72db763e0: mptcp: userspace pm send RM_ADDR for ID 0
>   - Note that I renamed the new helper to keep the 'mptcp_userspace_pm_'
>     prefix we can find in other helpers in this file.
> - Results: 9a34fc4dbad6..a1d8e0942055 (export-net)
> 
> Conflicts:
> - 9f7653e25504: conflict in
> t/net-mptcp-rename-netlink-handlers-to-mptcp_pm_nl_-blah-_-doit-dumpit
> - 1dae6c24941f: conflict in t/mptcp-define-more-local-variables-sk
> - bff6a9fde262: conflict in
> t/selftests-mptcp-update-userspace-pm-test-helpers
> - Results: 65682b5b41eb..554ef3499597 (export)
> 
> Squash-to patches:
> - 964ed0906f76: "squashed" patch 3/9 in "selftests: mptcp: userspace pm
> create id 0 subflow"
> - 6a9ab12adf72: "squashed" patch 4/9 in "mptcp: add
> mptcpi_subflows_total counter"
> - a65a15f44388: "squashed" patch 5/9 in "selftests: mptcp: add
> chk_subflows_total helper"
> - e5424462cd82: tg:msg: update after the recent squash-to patch
> - Results: 554ef3499597..7592debc8c8b (export)
> 
> New patches for t/upstream:
> - 492717f096ae: mptcp: userspace pm rename remove_err to out
> - 702694cb477d: selftests: mptcp: userspace pm send RM_ADDR for ID 0

Oops, I forgot patch 6/9. Just added before "selftests: mptcp: userspace
pm send RM_ADDR for ID 0":

New patches for t/upstream:
- 4118c35872b6: selftests: mptcp: userspace pm remove initial subflow
- ee73a6e81efa: conflict in
t/selftests-mptcp-userspace-pm-send-RM_ADDR-for-ID-0
- Results: 1b6c8d99ae9c..368681114ab6 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20231022T231456

Cheers,
Matt
