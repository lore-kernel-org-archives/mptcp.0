Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFE333C1B7;
	Sun, 24 May 2026 12:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779624582; cv=none; b=fk4pyz7njMASI3JfrjNeLvvbkcRHg7OwwCbqC2JebkWrFC/7+7aMqlgB1bOxTaWYS+ZLgScXGDp+ct1H3gL2C1iEkqAjGh+cZk/Y+W1CnXPlBt2qjc8bcDtI568S4Sq0DO27zXwVv2MdW7g7Tf38au5hySh08Dchj/lmG+Mbp2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779624582; c=relaxed/simple;
	bh=Hl9QoSe9XJTLFSgazDj1a8o5f+32uOFaFnhjfznZRGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=twkjjk4fK3vqaLRUVelfgJZ7EbswE06OIcZwu7rDhYYbGVF86he8y2SmFRohV4oGcExJeOW/4UUGb8Sk40sfPEzMDFrf7E38QhP826XnyZpvIeVA/wQuvp5et8PeFaG9+Unpa+SCcLZhoPzeEak+q/NduArL1V2vkEPN2f0Ehhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fwv08tBI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fwv08tBI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BED31F000E9;
	Sun, 24 May 2026 12:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779624581;
	bh=J9BXVb3slJU1Eu9UJPNqqVJ94Fcdm0PgUFuFxcsE4Pg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fwv08tBIKBvzwX3NdlhNdKu9+sRKJEwYKnzgH39te+E4/nX3dbD2l4qu53DEz2HmF
	 EhGy02WW0Phfe8l5CntmJmqdLPid6QRL3EAU3Z3HOW6VRVGgZaYWFjWt/bdVQl0ywa
	 xuYp2LX312EiFShkpbjU5am43qv74VhTLklbcAC/eC0yMkH8LDXmCDEKcjLQsmUNYL
	 6CCm0I0xAyOHgn7DgRKLHjlPQkwH3CM43Ih6RZQUKsQlhoeHSEaxRdSpJeN6hzSj1K
	 Y3v/ToDtxtQwpxdKcDzA9k9a0GD+PRphpcNjC30z4oiC7J0SINqmSn98sqeJUy7gKQ
	 puN46uLrXl57w==
From: Sasha Levin <sashal@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: Re: [PATCH 6.6.y 0/4] mptcp: fix recent failed backports (20260521)
Date: Sun, 24 May 2026 08:09:38 -0400
Message-ID: <20260524-stable-item001b-queued@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260521031906.740857-6-matttbe@kernel.org>
References: <20260521031906.740857-6-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
