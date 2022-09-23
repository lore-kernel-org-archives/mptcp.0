Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A503D63
	for <mptcp@lists.linux.dev>; Fri, 23 Sep 2022 13:41:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1663940504; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=fwHb4wHoGUmgoSaxH2C6WXHmsYCVVeV4fATL1mYeVtjVmGw2Kcvm3IeYnKPkVU5s+F3fM4Gb3jdnaFoSNFFjU56QYxf90yk94OanIrxGKHfYjMI+bZPyGbm0hyVxewEGoScXkfwdFppsxUesI69NvNttp/CtwdBSaDatn61TIbM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1663940504; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=tA7hP+Cs+8y4vYEmx6SsskM+aD3GpOd3DzxyN7zXHaM=; 
	b=JD2XklxAJE9XX0vUoaiKyHZItFk6wIpzmq7wJNslfRzahfG2KoiCFCGvVXPpXxvIwCYDpDDEAX29mXrXVn5/YvVIxAyJcajoCxQi7B6XXbtmSNKxkJ9DQIFv04HHH+UERpwBgdtBiFROmryQS5YWdxuUpxhpscws6ChyDA61Esk=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1663940504;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:Message-ID:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=tA7hP+Cs+8y4vYEmx6SsskM+aD3GpOd3DzxyN7zXHaM=;
	b=aJRN0xAYZrPtFYY84ZqTaBG4JDknNvbsGOMfwb+IgbK1A1apTZyJVryvckOf6txl
	0ww3k5hytFUnDXVrPBlMAggJ1A1afxYkvMftjkGr8TWm2FX2auTpBpaCfcDHO1mwkq2
	UwxCpNeP++TCwqhx01Xjh6UJHIEDOX34YGJQ7LvI=
Received: from [192.168.1.25] (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1663940501112125.51465935932424; Fri, 23 Sep 2022 15:41:41 +0200 (CEST)
Date: Fri, 23 Sep 2022 15:41:39 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH mptcp-next v2 0/4] mptcp: add support for TFO, sender side
 only
Content-Language: fr
To: Matthieu Baerts <matthieu.baerts@tessares.net>,
 benjamin.hesmans@tessares.net, mptcp@lists.linux.dev, pabeni@redhat.com
References: <20220921125558.19483-1-dmytro@shytyi.net>
 <709a843b-b7f7-438d-39c6-f139aaa55a10@shytyi.net>
 <3d37f47b-dd2e-fe80-caab-d1863028d7f1@tessares.net>
From: Dmytro Shytyi <dmytro@shytyi.net>
Message-ID: <deea610c-8f09-fbbe-5bbe-7a8900a3b9cd@shytyi.net>
In-Reply-To: <3d37f47b-dd2e-fe80-caab-d1863028d7f1@tessares.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External

Hello,

I am sharing experience from using the patch with environment that is=20
provided to test the patch with selftest ( As i mentioned before).
I take me some time to launch the patch. Hope this will help.

On 9/23/2022 12:58 PM, Matthieu Baerts wrote:
> Hi Dmytro,
>
> On 23/09/2022 01:23, Dmytro Shytyi wrote:
>> Hello Benjamin, All,
>>
>> I excuse for the later if I made any mistake.
>>
>> My thought is comming from experience with the patch.
>>
>>
>> Will huge respect, I think this patch _*MUST NOT*_ be accepted because
>> of multiple reasons:
>>
>> 1. it violates the RFC 8684 [1] section B1:
>>
>> "When a TFO initiator first connects to a listener, it cannot
>> immediately include data in the SYN for security reasons[RFC7413
>> <https://www.rfc-editor.org/rfc/rfc8684.html#RFC7413>]. Instead, it
>> requests a cookie that will be used in subsequent connections."
>>
>>
>> Also I created environment[3] using commit[2], I tested v0, v2 and I do
>> not see the mptcp capable option in SYN.
>  From what I see in your setup, you set net.ipv4.tcp_fastopen:
> - The sender has the 0x4 flag to send data in the opening SYN regardless
> of cookie availability and without a cookie option.
> - The receiver has the 0x200 flag to accept data-in-SYN w/o any cookie
> option present
>
> See the link below for more details about the bitmap:
>
> https://www.kernel.org/doc/html/latest/networking/ip-sysctl.html
>
> If you change these values, I guess you will see the TFO cookie option.
>
> Please note that the proper way to validate exchanged packet is to use
> Packetdrill. The following PR proves the implementation works with TFO
> cookies:
>
> https://github.com/multipath-tcp/packetdrill/pull/87

Could you please verify this with wireshark before the acceptence?

In evironment provided by the benjamins patch I cannot see the cookie,=20
nither if I create sender in C=C2=A0 (that is not using mptcpize as in the=
=20
exemple from packet drill:

mptcp: new fastopen-invalid-buf-ptr test =C2=B7=20
multipath-tcp/packetdrill@af86f4d (github.com)=20
<https://github.com/multipath-tcp/packetdrill/commit/af86f4d67c2595b6edd667=
a89ba9a838308142e2>

or this

Support TCP Fast Open =C2=B7 Issue #49 =C2=B7 rust-lang/socket2 (github.com=
)=20
<https://github.com/rust-lang/socket2/issues/49>

The cookie is not seen neither with curl:

 =C2=A0neither with *.c client, configured

neither with:

-netns client sysctl net.ipv4.tcp_fastopen=3D1

-netns server sysctl net.ipv4.tcp_fastopen=3D3

neighter with default Benjamin's setup.


I attach an exemple of c.* file in case if I made any mistake.

"

sock_fd =3D socket(AF_INET, SOCK_STREAM, IPPROTO_MPTCP);

I attach the code from *.C file:

setsockopt(sock_fd, SOL_TCP, TCP_FASTOPEN_CONNECT, &enable, sizeof(enable))=
;

connect(sock_fd, (struct sockaddr *) &daddr, sizeof(daddr));

ret =3D sendto(sock_fd, sendline, strlen(sendline), 0,(struct sockaddr=20
*)&daddr, sizeof(daddr));

"

>> 2. Abscense of MP_CAPABLE in SYN=C2=A0 violates the RFC 8684 [1] section=
 B3.
> The Packetdrill tests also shows everything is OK with MPTCP.
> I suppose there is an issue with your test environment and some paths
> (e.g. libmptcpwrap.so) are probably wrong, justifying why you get a 404
> error when doing the curl:
>
>    "GET /tfo.sh HTTP/1.1" 404
>
> Please do the validation without mptcpize, e.g. with packetdrill:
>
> https://github.com/multipath-tcp/packetdrill/blob/f3672b80a687e0e2a599269=
92f28c165783ecf8b/gtests/net/mptcp/fastopen/client-TCP_FASTOPEN_CONNECT.pkt
>
>> 3. Patch uses an original Idea of another autor from mailing list (Reuse
>> the TCP FASTOPEN option in MPTCP).
> A v3 mentioning you is going to be sent as discussed at the last meeting.
>
> We should indeed mention the authors of the original idea to have TFO in
> MPTCP:
>
> https://datatracker.ietf.org/doc/draft-barre-mptcp-tfo/
>
> Cheers,
> Matt

It seems this draft didn't get the consensus and was not accepted by=20
IETF as RFC. How the abstract RFC related to the original idea to reuse=20
TFO option from regular TCP in linux kernel implementation?


