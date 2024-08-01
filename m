Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBC11EB4BD
	for <mptcp@lists.linux.dev>; Thu,  1 Aug 2024 10:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722506661; cv=none; b=Hy0I4MMi0fQegNdNfF6w5LTGGDJnf4XzBP0T7dSgkybJLxbcY0+vkZL0lgX8/4o06+ajaGeMuEZMxWdRXSD4WrbaLrA2NMfJa5i7f+RJYtKGNM8TOnrE407lvJGGAECS+meAEgSIzjBKbqmYDySCyuCYpBEotWVYZ6U+P2QF7jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722506661; c=relaxed/simple;
	bh=8Jshab6CUZsiT5HLP2S2vtnUa5HtBXcZ/kghSJJMGeg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DyNV03GyjL+GM+2+8DSjPOIrtktV9EfZuleIDdKjdzSoB6nXeg2xGjsSqbPVAqD4c8lhIUeWGchnE8+Cab/Sb8Gd0MrTtLMB5MxeUPyrJ3jte2oyBAW6Pd4ajFqSRubyb4jcdXkgkVj0SsSvTm2ZdIuB1rxEKNon7UnyPVnd01o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQ1HNoAx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQ1HNoAx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF1FC32786;
	Thu,  1 Aug 2024 10:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722506661;
	bh=8Jshab6CUZsiT5HLP2S2vtnUa5HtBXcZ/kghSJJMGeg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kQ1HNoAxv2frBzAUfpZOsyDwdxDQpRglscaV8i9Bj5seaF3vT8ouxYCihd5vigUVz
	 mMg0Pv2V4ird7hGPqVlj/60HScJQNh4urvc74svqouvQ8OjterA+ThPuOkYu0LUyqT
	 AhEOiyJPQ1+mqcIZ4xHEawcURKHJ4iTWnvVZU+RuUGStZey3jfdbfRcAI720ykOXac
	 TAithqCM9KQY/21cK4VW5YfsZZphRuoExLKM1a8bpc0lQlPd8BV5n1QTDvvXi+3hWF
	 Qaf/uOhrm0ohIo5TrCywpg3QkCW5ob56UgDJt8F1jvJCZMeqChozNLYDhFtspiCJG7
	 3/Nr+kdbYDFzQ==
Message-ID: <d2512324-d629-433f-980b-af9c472f4825@kernel.org>
Date: Thu, 1 Aug 2024 12:04:18 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 2/4] selftests: mptcp: add io thread mode for
 mptcp_connect
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1722502941.git.tanggeliang@kylinos.cn>
 <f9916421f696012669a02d200f91a904df513cd6.1722502941.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 xsFNBFXj+ekBEADxVr99p2guPcqHFeI/JcFxls6KibzyZD5TQTyfuYlzEp7C7A9swoK5iCvf
 YBNdx5Xl74NLSgx6y/1NiMQGuKeu+2BmtnkiGxBNanfXcnl4L4Lzz+iXBvvbtCbynnnqDDqU
 c7SPFMpMesgpcu1xFt0F6bcxE+0ojRtSCZ5HDElKlHJNYtD1uwY4UYVGWUGCF/+cY1YLmtfb
 WdNb/SFo+Mp0HItfBC12qtDIXYvbfNUGVnA5jXeWMEyYhSNktLnpDL2gBUCsdbkov5VjiOX7
 CRTkX0UgNWRjyFZwThaZADEvAOo12M5uSBk7h07yJ97gqvBtcx45IsJwfUJE4hy8qZqsA62A
 nTRflBvp647IXAiCcwWsEgE5AXKwA3aL6dcpVR17JXJ6nwHHnslVi8WesiqzUI9sbO/hXeXw
 TDSB+YhErbNOxvHqCzZEnGAAFf6ges26fRVyuU119AzO40sjdLV0l6LE7GshddyazWZf0iac
 nEhX9NKxGnuhMu5SXmo2poIQttJuYAvTVUNwQVEx/0yY5xmiuyqvXa+XT7NKJkOZSiAPlNt6
 VffjgOP62S7M9wDShUghN3F7CPOrrRsOHWO/l6I/qJdUMW+MHSFYPfYiFXoLUZyPvNVCYSgs
 3oQaFhHapq1f345XBtfG3fOYp1K2wTXd4ThFraTLl8PHxCn4ywARAQABzSRNYXR0aGlldSBC
 YWVydHMgPG1hdHR0YmVAa2VybmVsLm9yZz7CwZEEEwEIADsCGwMFCwkIBwIGFQoJCAsCBBYC
 AwECHgECF4AWIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZUDpDAIZAQAKCRD2t4JPQmmgcz33
 EACjROM3nj9FGclR5AlyPUbAq/txEX7E0EFQCDtdLPrjBcLAoaYJIQUV8IDCcPjZMJy2ADp7
 /zSwYba2rE2C9vRgjXZJNt21mySvKnnkPbNQGkNRl3TZAinO1Ddq3fp2c/GmYaW1NWFSfOmw
 MvB5CJaN0UK5l0/drnaA6Hxsu62V5UnpvxWgexqDuo0wfpEeP1PEqMNzyiVPvJ8bJxgM8qoC
 cpXLp1Rq/jq7pbUycY8GeYw2j+FVZJHlhL0w0Zm9CFHThHxRAm1tsIPc+oTorx7haXP+nN0J
 iqBXVAxLK2KxrHtMygim50xk2QpUotWYfZpRRv8dMygEPIB3f1Vi5JMwP4M47NZNdpqVkHrm
 jvcNuLfDgf/vqUvuXs2eA2/BkIHcOuAAbsvreX1WX1rTHmx5ud3OhsWQQRVL2rt+0p1DpROI
 3Ob8F78W5rKr4HYvjX2Inpy3WahAm7FzUY184OyfPO/2zadKCqg8n01mWA9PXxs84bFEV2mP
 VzC5j6K8U3RNA6cb9bpE5bzXut6T2gxj6j+7TsgMQFhbyH/tZgpDjWvAiPZHb3sV29t8XaOF
 BwzqiI2AEkiWMySiHwCCMsIH9WUH7r7vpwROko89Tk+InpEbiphPjd7qAkyJ+tNIEWd1+MlX
 ZPtOaFLVHhLQ3PLFLkrU3+Yi3tXqpvLE3gO3LM7BTQRV4/npARAA5+u/Sx1n9anIqcgHpA7l
 5SUCP1e/qF7n5DK8LiM10gYglgY0XHOBi0S7vHppH8hrtpizx+7t5DBdPJgVtR6SilyK0/mp
 9nWHDhc9rwU3KmHYgFFsnX58eEmZxz2qsIY8juFor5r7kpcM5dRR9aB+HjlOOJJgyDxcJTwM
 1ey4L/79P72wuXRhMibN14SX6TZzf+/XIOrM6TsULVJEIv1+NdczQbs6pBTpEK/G2apME7vf
 mjTsZU26Ezn+LDMX16lHTmIJi7Hlh7eifCGGM+g/AlDV6aWKFS+sBbwy+YoS0Zc3Yz8zrdbi
 Kzn3kbKd+99//mysSVsHaekQYyVvO0KD2KPKBs1S/ImrBb6XecqxGy/y/3HWHdngGEY2v2IP
 Qox7mAPznyKyXEfG+0rrVseZSEssKmY01IsgwwbmN9ZcqUKYNhjv67WMX7tNwiVbSrGLZoqf
 Xlgw4aAdnIMQyTW8nE6hH/Iwqay4S2str4HZtWwyWLitk7N+e+vxuK5qto4AxtB7VdimvKUs
 x6kQO5F3YWcC3vCXCgPwyV8133+fIR2L81R1L1q3swaEuh95vWj6iskxeNWSTyFAVKYYVskG
 V+OTtB71P1XCnb6AJCW9cKpC25+zxQqD2Zy0dK3u2RuKErajKBa/YWzuSaKAOkneFxG3LJIv
 Hl7iqPF+JDCjB5sAEQEAAcLBXwQYAQIACQUCVeP56QIbDAAKCRD2t4JPQmmgc5VnD/9YgbCr
 HR1FbMbm7td54UrYvZV/i7m3dIQNXK2e+Cbv5PXf19ce3XluaE+wA8D+vnIW5mbAAiojt3Mb
 6p0WJS3QzbObzHNgAp3zy/L4lXwc6WW5vnpWAzqXFHP8D9PTpqvBALbXqL06smP47JqbyQxj
 Xf7D2rrPeIqbYmVY9da1KzMOVf3gReazYa89zZSdVkMojfWsbq05zwYU+SCWS3NiyF6QghbW
 voxbFwX1i/0xRwJiX9NNbRj1huVKQuS4W7rbWA87TrVQPXUAdkyd7FRYICNW+0gddysIwPoa
 KrLfx3Ba6Rpx0JznbrVOtXlihjl4KV8mtOPjYDY9u+8x412xXnlGl6AC4HLu2F3ECkamY4G6
 UxejX+E6vW6Xe4n7H+rEX5UFgPRdYkS1TA/X3nMen9bouxNsvIJv7C6adZmMHqu/2azX7S7I
 vrxxySzOw9GxjoVTuzWMKWpDGP8n71IFeOot8JuPZtJ8omz+DZel+WCNZMVdVNLPOd5frqOv
 mpz0VhFAlNTjU1Vy0CnuxX3AM51J8dpdNyG0S8rADh6C8AKCDOfUstpq28/6oTaQv7QZdge0
 JY6dglzGKnCi/zsmp2+1w559frz4+IC7j/igvJGX4KDDKUs0mlld8J2u2sBXv7CGxdzQoHaz
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <f9916421f696012669a02d200f91a904df513cd6.1722502941.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 01/08/2024 11:21, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch adds a new io mode "thread" for mptcp_connect, it creates a
> new thread to send data meanwhile receiving data in main thread.

Please add the reason why it is interesting to do that, something
similar to what you said in your cover-letter: not covered, bugs have
been found, link to #487.

> copyfd_io_thread() comes from BPF selftests network_helpers.c.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  .../selftests/net/mptcp/mptcp_connect.c       | 105 ++++++++++++++++++
>  1 file changed, 105 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> index ce261a4bb324..477969ba9653 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c

(...)

> @@ -105,6 +108,8 @@ static struct tcp_inq_state tcp_inq;
>  static struct cfg_cmsg_types cfg_cmsg_types;
>  static struct cfg_sockopt_types cfg_sockopt_types;
>  
> +static unsigned int io_thread_total_bytes = 10 * 1024 * 1024;

Is it enough to always reproduce the bug? (I didn't check)
Did you not say that if it was bigger, it would trigger the bug
quicker/directly?

> +
>  static void die_usage(void)
>  {
>  	fprintf(stderr, "Usage: mptcp_connect [-6] [-c cmsg] [-f offset] [-i file] [-I num] [-j] [-l] "

Please add your new option here.

> @@ -139,6 +144,11 @@ static void die_usage(void)
>  	exit(1);
>  }
>  
> +static void *ERR_PTR(long error)
> +{
> +	return (void *)error;
> +}
> +
>  static void xerror(const char *fmt, ...)
>  {
>  	va_list ap;
> @@ -938,6 +948,94 @@ static int copyfd_io_sendfile(int infd, int peerfd, int outfd,
>  	return err;
>  }
>  
> +struct io_thread_arg {
> +	int		fd;
> +	uint32_t	bytes;
> +	int		stop;
> +};
> +
> +static void *send_thread(void *arg)
> +{
> +	struct io_thread_arg *a = (struct io_thread_arg *)arg;
> +	ssize_t nr_sent = 0, bytes = 0;
> +	int err = 0, fd = a->fd;
> +	char batch[1500];
> +
> +	while (bytes < a->bytes && !a->stop) {
> +		nr_sent = send(fd, &batch,
> +			       MIN(a->bytes - bytes, sizeof(batch)), 0);
> +		if (nr_sent == -1 && errno == EINTR)
> +			continue;
> +		if (nr_sent == -1) {
> +			err = -errno;
> +			break;
> +		}
> +		bytes += nr_sent;
> +	}
> +
> +	if (bytes != a->bytes) {
> +		printf("send %zd expected %u\n", bytes, a->bytes);

Should it be printed to stderr?
(or use xerror()? But it will exit during the transfer, I guess we don't
want that?)

> +		if (!err)
> +			err = bytes > a->bytes ? -E2BIG : -EINTR;
> +	}
> +
> +	if (err) {
> +		a->stop = 1;
> +		return ERR_PTR(err);
> +	}
> +	return NULL;
> +}
> +
> +static int copyfd_io_thread(int peerfd, int fd, uint32_t total_bytes)
> +{
> +	ssize_t nr_recv = 0, bytes = 0;
> +	struct io_thread_arg arg = {
> +		.fd	= fd,
> +		.bytes	= total_bytes,
> +		.stop	= 0,
> +	};
> +	pthread_t thread;
> +	void *thread_ret;
> +	char batch[1500];
> +	int err;
> +
> +	err = pthread_create(&thread, NULL, send_thread, (void *)&arg);
> +	if (err) {
> +		printf("Failed to pthread_create\n");

Same here for stderr, same below, there are 2 others.

> +		goto done;
> +	}
> +
> +	/* recv total_bytes */
> +	while (bytes < total_bytes && !arg.stop) {
> +		nr_recv = recv(peerfd, &batch,
> +			       MIN(total_bytes - bytes, sizeof(batch)), 0);
> +		if (nr_recv == -1 && errno == EINTR)
> +			continue;
> +		if (nr_recv == -1) {
> +			err = -errno;
> +			break;
> +		}
> +		bytes += nr_recv;
> +	}
> +
> +	if (bytes != total_bytes) {
> +		printf("recv %zd expected %u\n", bytes, total_bytes);
> +		if (!err)
> +			err = bytes > total_bytes ? -E2BIG : -EINTR;
> +	}
> +
> +	arg.stop = 1;
> +	pthread_join(thread, &thread_ret);
> +	if (thread_ret) {
> +		printf("Failed in thread_ret %ld\n", (long)thread_ret);
> +		err = err ? : (long)thread_ret;
> +	}
> +
> +done:
> +	close(peerfd);
> +	return err;
> +}
> +
>  static int copyfd_io(int infd, int peerfd, int outfd, bool close_peerfd, struct wstate *winfo)
>  {
>  	bool in_closed_after_out = false;
> @@ -970,6 +1068,11 @@ static int copyfd_io(int infd, int peerfd, int outfd, bool close_peerfd, struct
>  					 &in_closed_after_out, winfo);
>  		break;
>  
> +	case CFG_MODE_THREAD:
> +		ret = copyfd_io_thread(peerfd, outfd,
> +				       io_thread_total_bytes);
> +		break;
> +
>  	default:
>  		fprintf(stderr, "Invalid mode %d\n", cfg_mode);
>  
> @@ -1352,6 +1455,8 @@ int parse_mode(const char *mode)
>  		return CFG_MODE_MMAP;
>  	if (!strcasecmp(mode, "sendfile"))
>  		return CFG_MODE_SENDFILE;
> +	if (!strcasecmp(mode, "thread"))
> +		return CFG_MODE_THREAD;
>  
>  	fprintf(stderr, "Unknown test mode: %s\n", mode);
>  	fprintf(stderr, "Supported modes are:\n");

Can you document the new mode here as well please?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

