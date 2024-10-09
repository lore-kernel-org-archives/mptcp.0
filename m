Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F251A2562
	for <mptcp@lists.linux.dev>; Wed,  9 Oct 2024 15:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728487818; cv=none; b=MUzGlSpLosOHpoNEIx3u/O5QOWdtBSpz2Os/ibTwebWMrXOZzZXqlOU1DZG95eRYPBtkO209GXtSK5XBYKynFEUxRbhBz9NOUFYV3VutmHOzPkOaCc2HlxOa4eA6+Pu6z3ElgvwEdKy8B9PpsCKAm4TT/Rel5sg6iL1ZumsnsTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728487818; c=relaxed/simple;
	bh=KdZDa9To6Wu+tLPfhE9QpSmBB8ayYntIvu4cMxf4XZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kYKayOOefBt7NYu+Qdd9qFIQc5itIHLlncAyKbURZXlrijbEzAAhLMNfUexPsgTok9go2pFAnybx/8C33GPOtSnbGa9qqWrypx05ctNltCBeWwdvuiC7LGrRSBjcPZ8qwVA9D39dbO3SK012im+t+6eze5LUn5QgnZP6alTXtjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fdrm1yQE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdrm1yQE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81E95C4CEC5;
	Wed,  9 Oct 2024 15:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728487817;
	bh=KdZDa9To6Wu+tLPfhE9QpSmBB8ayYntIvu4cMxf4XZc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fdrm1yQE522UKMyjVZkI5H5pWopEMJos+eMNfn8scaSQLUzmoooOicUqXnlHOqArw
	 1jShN7EDYDok8K6PSzlrxVP5849VCjQeHTOdjimPu48IRRCePVYTGtt7iyjygWDdE3
	 0SSGswcFctpL9wu2iXoxtCi2fEpz36BvAM6nsd/7gglZ/uTmPpkMRZyLh3bfQZFMkO
	 dyxo1e9swsUNXE8dJcPGjN9v2n3VTeEy+qCghPERLnag5wViMLlWosWckg2+Jn0fE3
	 oX6PgrlWrm74TmrwNCTurBzcAcG4sckJNoxfuaVAaDeJQuMR8NxeZLqvOvYuRE8TOc
	 VmxpP4nAVVRSw==
Message-ID: <02fa00c2-aa85-44ef-8b07-6469d7dc149a@kernel.org>
Date: Wed, 9 Oct 2024 17:30:13 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v3 0/2] mptcp: prevent MPC handshake on
 port-based signal endpoints
Content-Language: en-GB
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>,
 Cong Wang <cong.wang@bytedance.com>,
 syzbot+f4aacdfef2c6a6529c3e@syzkaller.appspotmail.com
References: <20241008-mpc-hs-port-v3-0-cec1363f0353@kernel.org>
 <538e38b3-e485-5b0f-0ae2-93fb1d9c0ee9@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <538e38b3-e485-5b0f-0ae2-93fb1d9c0ee9@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

On 09/10/2024 01:40, Mat Martineau wrote:
> On Tue, 8 Oct 2024, Matthieu Baerts (NGI0) wrote:
> 
>> This is a new version for the series sent by Paolo, related to the
>> lockdep splat Syzbot reported a few weeks ago, and for which Cong Wang
>> sent a different attempt (Thanks both!).
>>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>> Changes in v3:
>> - patch 1: reduce comments to fit under 80 chars
>> - patch 2:
>>  - Add Fixes tag + comment about it
>>  - Add my Co-dev tag instead of RvB
>>  - Add a note about the new helpers in the commit message
>>  - move cappid declaration under capout
>>  - move 'cat $capout' to cond_stop_capture
>>  - move 'local port' declaration above to keep the reversed Xmas tree
>>  - use 'retl' var instead of 'ret' to avoid a clash with the one used
>>    in fail_test(), which would not have marked the whole selftest as
>>    failed in case of problem only with this test.
>> - Link to v2: https://lore.kernel.org/r/20241007-mpc-hs-port-
>> v2-0-0c9e7827bd0f@kernel.org
> 
> Hi Matthieu -
> 
> v3 looks good to me, one minor change is to fix the "signl" typo in the
> subject line of patch 2 when applying.
Thank you for the review!

Good catch! I then slightly changed the subject that was a bit too long
with 'signal endp' to ...

  test for prohibited MPC to port-based endp

... similar to the comment in mib.h.


Now in our tree (fixes for -net):

New patches for t/upstream-net and t/upstream:
- 5fc467636d0e: mptcp: prevent MPC handshake on port-based signal endpoints
- 4e5550c94f5d: selftests: mptcp: join: test for prohibited MPC to
port-based endp
- Results: 3bedd77fcc0a..6b1ad544c6f8 (export-net)
- 776972a2f26f: conflict in
t/mptcp-annotate-data-races-around-subflow-fully_established
- Results: 1d4b8739f94e..f1fcd89f7da0 (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/2b9543b8dffd45921a4b440ccd7a03f4f42e3d6b/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/08d19140c7fd6fdffd6866c648637fa6373e53fe/checks


Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

