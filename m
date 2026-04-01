Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634DE3F9F31
	for <mptcp@lists.linux.dev>; Wed,  1 Apr 2026 17:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775065836; cv=none; b=KAVUEWvCSRUjtjuyT/7Qf7aPu++OObYxS9scw7LiLG5s3Yq8j24Si/OQ/EgqWQCU6B1QjBzv1nsMKn0Bc3S2NnM6biXwnoVjjtLZnSdDFoo0nDh0NK/fu7Oev2WpGykWSV3JIRDk9xpNzqfRrJSH1gR/RK/d/Zgk/cPrIKQ2JEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775065836; c=relaxed/simple;
	bh=SDG0auataPfZgEbfdBdEk/RWfUTb0BVBqcmf+0TGpEU=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=E8Rn5NAe2yLbcTDozD5NuHgIUTkaD8m+jdu5PAA9HSW8iYbVSQjVYfn74i9wUSa9WQTMxfM1XuFurDtjf+xoGzne1H20Nyp6V3orWNwnotM1brSd2cEX9ldRhIzoBLSq+uR4e4IrSW5DfNo/HorLMZ1b6tCUU3JP/RhWug40Tqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvUunean; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvUunean"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC79FC2BC9E;
	Wed,  1 Apr 2026 17:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775065836;
	bh=SDG0auataPfZgEbfdBdEk/RWfUTb0BVBqcmf+0TGpEU=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
	b=kvUuneanvm9nGdjs7DFZVfpeCTIgzWPM9O/dzupnA38YPOEMlRr3ahQCQh6xslh/T
	 R7RSHvDPGpNXmq6Ws81hdnWB9eIiS0OG0WBX7DBadoq9dxbeB8uNrQcPAUdW3GuEu5
	 AytW4Rp0AF7zI6xOuflDlk5iT8y76LmViEkUsHb+qej4KBYR88W9vIqcBh4Fio78L0
	 hS8MQSYIuAG8fq88uK3T+qFCN5hIH0be61xW9tPmb57/QoInt8eD92x0kDcpo9d7EC
	 vi8KVo0Tr92+ZKi8YLkiBdPIlzz53N30HjXNmGmFTTiSSUWa/t4dN2o/gVbDFnkOc8
	 UXETsRIbSblQg==
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH mptcp-next v2 1/2] mptcp: reduce 'overhead' from u16 to
 u8
From: Matthieu Baerts <matttbe@kernel.org>
To: Gang Yan <gang.yan@linux.dev>
Cc: mptcp@lists.linux.dev, Gang Yan <yangang@kylinos.cn>
In-Reply-To: <f6126a1dea5263fd2e934a0bb135755215e0fd7c.1774947296.git.yangang@kylinos.cn>
References: <cover.1774947296.git.yangang@kylinos.cn>
 <f6126a1dea5263fd2e934a0bb135755215e0fd7c.1774947296.git.yangang@kylinos.cn>
Date: Wed, 01 Apr 2026 19:50:24 +0200
Message-Id: <177506582485.2123138.16458149536718297275.b4-review@b4>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=700; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=SDG0auataPfZgEbfdBdEk/RWfUTb0BVBqcmf+0TGpEU=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLPRr26+/hg+aSjD68ryoXWiwt8XjS1xOq3a2aDkimn/
 pEdj1t2d5SyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAExkZhgjwxROvujj9U+n+Yh/
 znCRvXJ/VkdsTn5t9oOFHefvbmzxU2f4xTzrdPEUzUkrQuYq3dq4Z1/LzYtf1BcV8+ZNMnpfcDT
 mGTsA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

On Tue, 31 Mar 2026 17:08:08 +0800, Gang Yan <gang.yan@linux.dev> wrote:
> The 'overhead' in struct mptcp_data_frag can safely use u8, as it
> represents 'alignment + sizeof(mptcp_data_frag)'. With a maximum
> alignment of 7('ALIGN(1, sizeof(long)) - 1'), the overhead is at most
> 47, well below U8_MAX and validated with BUILD_BUG_ON().
> 
> This patch also adds a field named 'unused' for further extensions.
> 

Thank you, that's clearer like that in a dedicated patch.

We can probably add Paolo's suggested-by while at it.

Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Suggested-by: Paolo Abeni <pabeni@redhat.com>

-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>
