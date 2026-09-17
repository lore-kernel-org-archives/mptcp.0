Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754634B66FB;
	Thu, 17 Sep 2026 09:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789638342; cv=none; b=H/hIarR+onv8hDkaPykxMrZ85lRjIUz+zY/ERqOBoMfIX5SInLqAfGvzVCtQ95NiqIbTrXujxnNNtRp2snPtjSoEl0wg8CcmjJ9GyvOQtDxcMBY43VYFIgNJc8vjvyhVz+x0SAoEksXHAHKKAOPQBh+EU7ikuG7z2VlzN6whicI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789638342; c=relaxed/simple;
	bh=JTJNv6iHD/56X33Pk+RbiScJ1WGchFvt9lpLotbWIpI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=t81PYkHd258HulYw0gQnCxs++cO6cuT2ahAJkp/3uiHxYNgU/9aiSEhcFCSY2ASDszJSU0gqNn8+zVo/mLkY14OxQn6lUmxsRMrgy++/l9kphYfF1Vlzr6MhKgSZyadqsYcz5AO/dWiCP9tjx342RGoSu/jstnxRtqjX2HQ2kHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TekKEYFk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TekKEYFk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59D8F1F0089A;
	Thu, 17 Sep 2026 09:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789638323;
	bh=JTJNv6iHD/56X33Pk+RbiScJ1WGchFvt9lpLotbWIpI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=TekKEYFk1jJ3i2AocI9dPE4D4bIBWs0FDoU9LxAwH9ZBzILJgeiZvmLBPBTDk5MiY
	 T3pSjCcLZT1j41tyFNL0Cb18F5mY66hnIr8+dnlLhP4IXnMoBv5a0Kt6tmQHJS8RBr
	 UIrk+wvcgq6YeP2mHNhY00JZIEI+u/QQY3iv88E4WtnaQiIFe3Zl0vnypMqILXiSdB
	 nTdw5C45DyouX9XqMWuuIPL9btnKzdD3mqZr6FZN6f03OamtmlNaiJTjWFYuc6SyjX
	 gHgLIHwayeax3NysXxMPnW/Pc2IF5GdDeWEoHxSCHWHuerw6XGye8JQBwP6y+jZOPW
	 LhIf2ADMBpUpw==
Content-Type: multipart/mixed; boundary="===============1968874701090499589=="
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-Id: <b39121f2d0860a81719fb0b3f9b16bde9157bc043d7cc918497afc6d896877de@mail.kernel.org>
In-Reply-To: <85d9a0f138fa024354edde023a05f9d07b6ac87a.1789633546.git.tanggeliang@kylinos.cn>
References: <85d9a0f138fa024354edde023a05f9d07b6ac87a.1789633546.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH bpf-next v3] bpf: drop duplicate check_app_limited in tcp_bpf_push
From: bot+bpf-ci@kernel.org
To: geliang@kernel.org,john.fastabend@gmail.com,jakub@cloudflare.com,jiayuan.chen@linux.dev,edumazet@google.com,ncardwell@google.com,kuniyu@google.com,davem@davemloft.net,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,matttbe@kernel.org,martineau@kernel.org
Cc: tanggeliang@kylinos.cn,netdev@vger.kernel.org,bpf@vger.kernel.org,mptcp@lists.linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 17 Sep 2026 09:45:22 +0000 (UTC)

--===============1968874701090499589==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: drop duplicate check_app_limited in tcp_bpf_push
>
> Before commit c5c37af6ecad9 ("tcp: Convert do_tcp_sendpages() to use
> MSG_SPLICE_PAGES"), do_tcp_sendpages() did not call
> tcp_rate_check_app_limited() internally, so callers needed an explicit
> tcp_rate_check_app_limited() to cover it. That commit replaced
> do_tcp_sendpages() with direct tcp_sendmsg_locked() calls, which perform
> the check on every path that queues data. The outer call became redundant
> but was left in place.

This isn't a bug, but would it be clearer to cite ebf2e8860eea ("tcp_bpf:
Inline do_tcp_sendpages as it's now a wrapper around tcp_sendmsg") as the
commit that left the outer tcp_rate_check_app_limited() in tcp_bpf_push(),
with c5c37af6ecad9 mentioned as the commit that moved the check inside
do_tcp_sendpages()?

Looking at the git history, c5c37af6ecad9 only touched net/ipv4/tcp.c and
turned do_tcp_sendpages() into a wrapper that calls tcp_sendmsg_locked().
The direct tcp_sendmsg_locked() call in tcp_bpf_push() was introduced by
ebf2e8860eea, which kept the outer tcp_rate_check_app_limited(sk) while
inlining the wrapper.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35203307255
--===============1968874701090499589==--
