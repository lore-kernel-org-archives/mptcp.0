Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85D65672
	for <mptcp@lists.linux.dev>; Wed, 31 Jan 2024 01:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706664775; cv=none; b=SK7dugs6CdBy6MTaGHca8a2Vj9RwcYBX2BX7ZRqIEVofVhjt+GNJ8dnqMvjtXRSWXfNo9xCP3vbMX7+YICdkVTaFffWZz7bYhi7fORpFek9GmhW8pipXY56oeOt5r3VRGYjGR9kCIgOO+bMWVse1c8+VMhI10EGK9gy2N/aycQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706664775; c=relaxed/simple;
	bh=rVfMiyCbTXqYMfBfQsvnFXkGdcQplCBTQHlJzdSnVRc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=IsWLFpVAsDIIWlZCovgun/uDbYSkoJ9GcvA+t4byB4prkbuL2SREewrlJJ5aAymFjeEh30SYPpzF9uwktsEMQaSlOLXg7VMv07HWWhWrH/KmtEKfP7pu+kmv8wj997ITt82RRFYtE/1wnk/RyQJFgcPZZPubo+byTUgYKLi2w6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7lj4z4n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7lj4z4n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ACC3C433F1;
	Wed, 31 Jan 2024 01:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706664775;
	bh=rVfMiyCbTXqYMfBfQsvnFXkGdcQplCBTQHlJzdSnVRc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=n7lj4z4nL35tMm4PvahSJjIYyule1Ek1MSsGzUvQVqSL25ebLL5K3SzvcfwDtGo1u
	 69aM6aCnCEppLFA3RRVszg9P5f70xsT7y5BPW9KaKPBD2AmOi8dFEGZbvoi+nCTntT
	 DAv7CbvNDqTflUCOTAsdt2NBomzZHW/UnHvq2PdKX9yopapmI5lSmpGCh1YdY9tGyR
	 IUPYHa5DdsmkCzL7BXOOgtBhxL3KUSR7FHfoI45EbQxF2qqy+XeMM2CUzuOBWLCLyu
	 Q5BlYH31hLNLoJrPTo9eKirz7Rr5vnOb39Z4zVZkIrjm9l9vdEpkHPX2UFUHPTT/j5
	 c4lDqmgej2RvQ==
Date: Tue, 30 Jan 2024 17:32:54 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang@kernel.org>
cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v10 00/23] dump for userspace pm
In-Reply-To: <cover.1705558030.git.tanggeliang@kylinos.cn>
Message-ID: <5577b594-a4f5-e396-5610-2ead7b4c70ce@kernel.org>
References: <cover.1705558030.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Thu, 18 Jan 2024, Geliang Tang wrote:

> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> v10:
> - fix a checkpatch.sh warning reported by CI.
> - fix build warnings reported by kernel test robot <lkp@intel.com>.
>
> v9:
> - add missing "sock_put(sk)" in patch 7, 17 and 21 to fix the "kmemleak"
>   errors reported by CI.
> - rename the helper to mptcp_pm_has_addr_attr_id.
> - use my new mail address.
>

Hi Geliang -

Please also make sure you update MAINTAINERS and .mailmap with your 
geliang@kernel.org and tanggeliang@kylinos.cn addresses.

Thanks,
Mat
