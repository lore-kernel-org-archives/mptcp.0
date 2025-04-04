Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A9A199BC
	for <mptcp@lists.linux.dev>; Fri,  4 Apr 2025 01:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743731326; cv=none; b=fWEByTWLnc8pzz7NFjAImeevqpsiPf2qTNyrQL0ER7nsQyfxQfDEG2zCTC2Qmpbd6akHk472470ntJM4tUZHcL3GIRhPE+2zoQ0imO6coy25pJJT2X2oiWMb49PiXDiDUfxvMlxKxHBW92pY//0GwvYX7KdgMMTA9QjeFMc5JSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743731326; c=relaxed/simple;
	bh=fg6jzpY7ynhgEx4QnreeOlFHJsv5YhHpkJa4ipzlMEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DkdEvIlujvl+t2E6P+xSNr/jm4jVhyD35ac24lJnnC033j792rKI/oYeaD2PiFtKe2Uo9rglnIZwoQrK2s4qTMhqhNLwE3Ayq/zv1U8UBZVL/mmQa2u/NVkrwJC3gvbNnQRRtTI/gU2KpMlOKuTWsgxUZgyytsahiMN5s32Cs2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e470347810f611f0a216b1d71e6e1362-20250404
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_MISS
	HR_CTT_TXT, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:28b9cc99-9c79-4858-8074-ec90b6f0a202,IP:15,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-5
X-CID-INFO: VERSION:1.1.45,REQID:28b9cc99-9c79-4858-8074-ec90b6f0a202,IP:15,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:8e90c5f7b7ea1076a1c6a0ff8630a89d,BulkI
	D:250404094825LTQ5RE19,BulkQuantity:0,Recheck:0,SF:17|19|24|44|64|66|78|80
	|81|82|83|102|841,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:11|1,File:nil,RT:ni
	l,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,
	BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,
	TF_CID_SPAM_ULN
X-UUID: e470347810f611f0a216b1d71e6e1362-20250404
X-User: yangang@kylinos.cn
Received: from localhost [(39.156.73.13)] by mailgw.kylinos.cn
	(envelope-from <yangang@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1535756603; Fri, 04 Apr 2025 09:48:22 +0800
Date: Fri, 4 Apr 2025 09:47:55 +0800
From: Gang Yan <yangang@kylinos.cn>
To: Geliang Tang <geliang@kernel.org>
Cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next] selftests: mptcp: diag: use
 mptcp_lib_get_info_value
Message-ID: <20250404014700.GA14785@yangang-pc>
References: <e34e86805f3fe69e0aec08c83c596c49799573c7.1743666387.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e34e86805f3fe69e0aec08c83c596c49799573c7.1743666387.git.tanggeliang@kylinos.cn>

On Thu, Apr 03, 2025 at 03:46:37PM +0800, Geliang Tang wrote:
Hi, Geliang:

Thanks for the patch, this patch also works well in my enviroment.
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> When running diag.sh in a loop, chk_dump_one will report the following
> "grep: write error":
> 
>  13 ....chk 2 cestab                                  [ OK ]
>  grep: write error
>  14 ....chk dump_one                                  [ OK ]
>  15 ....chk 2->0 msk in use after flush               [ OK ]
>  16 ....chk 2->0 cestab after flush                   [ OK ]
> 
> This error is caused by a broken pipe. When the output of 'ss' is processed
> by grep, 'head -n 1' will exit immediately after getting the first line,
> causing the subsequent pipe to close. At this time, if 'grep' is still
> trying to write data to the closed pipe, it will trigger a SIGPIPE signal,
> causing a write error.
> 
> One solution is not to use this problematic "head -n 1" command, but to use
> mptcp_lib_get_info_value() helper defined in mptcp_lib.sh to get the value
> of 'token'.
> 
> Fixes: ba2400166570 ("selftests: mptcp: add a test for mptcp_diag_dump_one")
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Tested-by: Gang Yan <yangang@kylinos.cn>
> ---
>  tools/testing/selftests/net/mptcp/diag.sh | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
> index 4f55477ffe08..e7a75341f0f3 100755
> --- a/tools/testing/selftests/net/mptcp/diag.sh
> +++ b/tools/testing/selftests/net/mptcp/diag.sh
> @@ -206,9 +206,8 @@ chk_dump_one()
>  	local token
>  	local msg
>  
> -	ss_token="$(ss -inmHMN $ns | grep 'token:' |\
> -		    head -n 1 |\
> -		    sed 's/.*token:\([0-9a-f]*\).*/\1/')"
> +	ss_token="$(ss -inmHMN $ns |
> +		    mptcp_lib_get_info_value "token" "token")"
>  
>  	token="$(ip netns exec $ns ./mptcp_diag -t $ss_token |\
>  		 awk -F':[ \t]+' '/^token/ {print $2}')"
> -- 
> 2.43.0
> 
> 
Best wishes!
Gang
