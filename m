Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0CE19C556
	for <mptcp@lists.linux.dev>; Wed, 30 Jul 2025 22:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753913068; cv=none; b=N8EW6ZOzd6R9FXSkV8TnWjaION0X7NTEpNpBUiJuStOoBYDyVvYgCMp5fmxtPc+/dNkEB0PKwb72dBhVCRp2EMlWw2Xs4CFrbb0rMw7IJhEl146U2mQaj1VAVTEo/e8BJ5/B5YnBXlhdNlBMGVk6Wt1drriHCVrYvgNgtmhPlaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753913068; c=relaxed/simple;
	bh=oDB+082Pfb32uQDmgMiPW/pN5HG48NXKtFcdLAb7E8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VZRpDDMRDf7TXWCNllQtGkkI+a5K2eSHtHdUpY1jZNdVNs1dyP0G9gCIFPyxePuYaCa0G2QV7LgU1KWb/+JMZq7i/qXu6x4JxJpj5KD9oQ5Y0Zsgy93IiZUxn7hgP0cOJR4gRZe2ccpb79C1OdwAnLi8BXE90IXY0YXkaJOYmTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J6Crz4P5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6Crz4P5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8042C4CEE3;
	Wed, 30 Jul 2025 22:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753913067;
	bh=oDB+082Pfb32uQDmgMiPW/pN5HG48NXKtFcdLAb7E8Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=J6Crz4P5xt5A7C/zRFGtFKhsrof6bsnhMoTGGipSDvjwYC6XarmpRJ/XDpm9s/VFz
	 0HBSH62INceqk1+t2OrCFn+4rDWVz/AkGn+LbWZzxyi/YlQlMJCANhFwxABIScOZea
	 ZJgCS0JIdxuhokV0xpZil3W3EgBt0TPkfQQLvJPmyQ766oqDBbceXSGogXjBDhWCAF
	 SyHIkuE3VTPCgLdS0YwOOKhEFwVwrxjndKAstPs1Z3ZAPJ7tezu/zjx1Ax6NFwpNlB
	 xzqFHOZfbYzR3cTu7JIsuqK5b2GBoUZLJuhuo4pJdPTbcgYoO5Lyek/PIHaJad8gYr
	 VR8764Noub3IQ==
Message-ID: <6ce1f0b6-105d-46a5-8257-38bf36182a88@kernel.org>
Date: Thu, 31 Jul 2025 00:04:25 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 2/7] Add MPTCP server socket creation support
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
References: <cover.1753247666.git.geliang@kernel.org>
 <931ce3edf07175a81607cfb0c00319c262462bc5.1753247666.git.geliang@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <931ce3edf07175a81607cfb0c00319c262462bc5.1753247666.git.geliang@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 23/07/2025 07:16, Geliang Tang wrote:
> This patch introduces new methods to create server sockets with Multipath
> TCP (MPTCP) support:
> 
> 1. Added an overloaded 'serverSocket' method that accepts an 'mptcp'
>    parameter to enable MPTCP
> 2. Added a convenience method 'mptcpServerSocket()' for creating
>    MPTCP-enabled server sockets using the unspecified protocol family by
>    default
> 
> The changes maintain backward compatibility while providing explicit MPTCP
> support for server socket creation. The new methods leverage the existing
> socket0 infrastructure with the MPTCP flag added in the previous patch.
> 
> Co-Developed-by: Gang Yan <yangang@kylinos.cn>
> Signed-off-by: Gang Yan <yangang@kylinos.cn>
> Signed-off-by: Geliang Tang <geliang@kernel.org>
> ---
>  src/java.base/share/classes/sun/nio/ch/Net.java | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/src/java.base/share/classes/sun/nio/ch/Net.java b/src/java.base/share/classes/sun/nio/ch/Net.java
> index c086429380b..aa3ed087d2c 100644
> --- a/src/java.base/share/classes/sun/nio/ch/Net.java
> +++ b/src/java.base/share/classes/sun/nio/ch/Net.java
> @@ -501,6 +501,16 @@ static FileDescriptor serverSocket(ProtocolFamily family) {
>          return IOUtil.newFD(socket0(preferIPv6, true, true, FAST_LOOPBACK, false));
>      }
>  
> +    static FileDescriptor serverSocket(ProtocolFamily family, boolean mptcp) {
> +        boolean preferIPv6 = isIPv6Available() &&
> +            (family != StandardProtocolFamily.INET);
> +        return IOUtil.newFD(socket0(preferIPv6, true, true, FAST_LOOPBACK, mptcp));
> +    }
> +
> +    static FileDescriptor mptcpServerSocket() {

I didn't check what is usually being done, but is this new helper really
needed? Is it not enough with the new serverSocket() extension?

Also, could you not have serverSocket(ProtocolFamily family) calling the
new serverSocket(family, false) instead of duplicating the code above?

> +        return serverSocket(UNSPEC, true);
> +    }
> +
>      // Due to oddities SO_REUSEADDR on Windows reuse is ignored
>      private static native int socket0(boolean preferIPv6, boolean stream, boolean reuse,
>                                        boolean fastLoopback, boolean mptcp);

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

